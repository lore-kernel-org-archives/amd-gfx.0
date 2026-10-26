Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB0F606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 17:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VV6LXnhx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662D310E1FD;
	Mon, 26 Oct 2026 17:29:38 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86CBE10E1FD
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 17:29:32 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-34c522572bfso417269eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 10:29:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793035772; cv=none;
 d=google.com; s=arc-20260327;
 b=dF90X+/Y96FpKrcpiiEY5NzfeqS71Z602Y2fcV6uOPbb3zcjEqx5AixuTXN9TvC//1
 V6kgx2z8vnON0zqK6h8VErreWuIYYreRqrP4Bgk9TMvsuoBIyNOIet4iRyg0N5en/BOv
 Fy5rL3CZJ+PYKUE9h8J9QXSnanjpYtjCQIXteAqz+7Tifmun97fA6mm6H9zmsds+2+4h
 Mdct59vMzRhpygy6B6GBuYkQiIFJAZKdF95svtGaQChK5X9asDMvXmE4EVnCJLc7b1hh
 tP0+zAatu9tbAi614D10+rFlFiLDynQLDmGeHic0gun7e4f2eL3oi8pmnN6P+8DjnNwK
 gmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=p08RsZsKOuP/IUJjUeVa0WS4/btERMeFMiEZgOF44p0=;
 fh=Hac/nQWjQ1OlMXz1l1TUARjJzaAgYT6B8geaOesyOjg=;
 b=o1UAImfhIcFdqHFhGlEHq1lKtGk2u7wQNqH6bdO7aLsqmZAXVHkEzF4ag9rI8WzloE
 6wCesOY7jbQTQGWim4yHxcZk1tTsi7uriIks+rAemvZv6zRuCWX0aa1UGZcAR43zFUqO
 qdL0hIe8tZlHsmpvAjPwVrxoTYptoRCqXnx1JEOijxivJGyO/hjwhgcs0bggQZ3vCy05
 vlsYrFbq3p7y7BU/V2/Ctn/HyL4/U0hSt9kds7Eqzstd4oslRT2nWdzNp/gmVMoLvvpD
 DV3IDKaNlMTQhlVycRg8eL9x7wCqfHViMe4QMLWkNUMBjVzAims4K6FYOMQ1FAtkASuw
 Nl+w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793035772; x=1793640572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p08RsZsKOuP/IUJjUeVa0WS4/btERMeFMiEZgOF44p0=;
 b=VV6LXnhxxgrcFIAXDrzHnDhoCLK3V7fePH5b97BbJIvqGQCCan0XpS5W+jFqipgIak
 qZNS1hpGLX047v8KpYTgggr3QFeL6lRIvn1oOE64q9PaNmqYKwVftU9mJ3WbRmnMyxjk
 An4FFNcGRJ7j/Jj8mP6ThzHzoslWTuBGFG1mdtOiqzlttInnIP4fbyBJtOzXGduowiDU
 BjcTIgXHI8R0myzof1Btq/KUTT9t/Ur1rxhhrDBRwatnqmwYEEFlUYgV9d5WQsCLoXU8
 v2keMmpGbdj/lD0Fscst/Csf0kxVwL9/eAx8GU+BamgRhr4a36t3ZS9WIsUTdoKbjQjU
 mInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793035772; x=1793640572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p08RsZsKOuP/IUJjUeVa0WS4/btERMeFMiEZgOF44p0=;
 b=wzxgfFB0rVhDvYOEcYeV5QlbhdTo+3t8FRGtE1gw3SkvKc9GLJ2lF/kmeCpExR2ZYW
 FnnS8mWLL7T+NcT4IlSpS/I7d6F6E2ijBiXWa3Acm0WxtmXtG9KrLuGqrYhd3/RbvmNL
 /pBfu84xPMS5j6mFktCXhnOxtCLghbI7KMqv4biWP+fElASSpq6mOYumhMdm9oW6DaoE
 2m77PosdEMLtcYb4QD6nz2J9064KFTgg7LJu3Bro8dGJDScm7+Vgys4mjFevm8HxEv6w
 nDMabAZG45Olu3m969CXaSJKc0BE0fQZPt2MPKsM0BPcRnZEIYQXa4JHdPS+jmbQozCq
 IZ0w==
X-Gm-Message-State: AFq9FYLnyH60DmrnfcIin1byLj4r/Uz3+LdkqPpt8V0OhbsH+KKvSk9g
 yEHPzOMD51e0HtXgM+mvVn2BoI4/LtONU3ud0iPDGq7gvCFO5JtOpiirZDGfpxmHqC4oOzFE0Bp
 /G/ABxHF7Ai4Ayhn0Clhxr0OaxnbWems=
X-Gm-Gg: AYBFou1HYq9JyNAdf2DbbEQxPQymkeScQk+a+tCo0az2hujqdXQL7gctkT8wSnPS/4l
 7JHj87eGfTp1FIdD9zIqVyiPYkNZKjsp3wblGow9DosJuhG2szn0i8zfBqszKuzFUObDj69vCrj
 WxU+DJmU7A+rG4YuGnNpf2M4J55mnwsgfsKAKjeeMhjTC5Nrw9AHd/VsJ4An9Br2sBZZkI2SXMk
 tc1wbvu1xtbB4h/0PABBxxh1C3nFtrJgw5MjUimOzKjgHnd6jeMoyOV5LPO8vOexdAPifWhMRz1
 POIuZU8PeIBFf66e3AK4pOkGrc/ypNStBFgBJEL1xOeFeO1pEBQerJ/rm+lIavEH7L+whYtmYii
 1U/9wGmdr0JxYEH8hLkU9ERInWW0G4oYzy84YWeJkXA9BybfpS6XQQj4PsZq6gNofm9ZPy3uPrz
 Ndd5x4V2pUo3vaNdodHbp32dE=
X-Received: by 2002:a05:7022:264b:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-199376df85bmr15225360c88.2.1793035771228; Mon, 26 Oct 2026
 10:29:31 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022215738.3248641-1-kent.russell@amd.com>
In-Reply-To: <20261022215738.3248641-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 13:29:19 -0400
X-Gm-Features: AclHuK8jKdGswIe2dB6yVmbBCK3sxzqax5phv8qUBYUnhBMyYAvH1GUgoPX1J6M
Message-ID: <CADnq5_NXH7MVG7tYKdesk9yQ0Z9UrNY7d9PtD=SSP8DLJTvKSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure that harvest information gets set
To: Kent Russell <kent.russell@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Mario.Limonciello@amd.com, 
 Hawking.Zhang@amd.com
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 6:06=E2=80=AFPM Kent Russell <kent.russell@amd.com>=
 wrote:
>
> After the earlier patch export IP discovery on probe failure, there was
> an unexpected consequence where harvest info was not populated. The
> early-exit in amdgpu_discovery_sysfs_init meant that we never called
> amdgpu_discovery_get_harvest_info, which is where we set the actual
> harvest value. The first time we call amdgpu_discovery_sysfs_recurse
> with NULL instead of adev, most values can get set. The 2nd time
> amdgpu_discovery_sysfs_recurse is called, we bail early.

Are there any other IP discovery tables that get missed?

Alex

>
> To keep the logic of the first patch intact, ensuring that older kernels
> can still discover the IP blocks, add a separate call in the early-exit
> section that sets the harvest information. This should be the only
> functionality that is missed in this flow, the rest of the calls either
> work fine with adev=3DNULL, or use the discovery_bin directly.
>
> Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe fail=
ure")
> Assisted-by: Claude:claude-opus-4
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 45 +++++++++++++++++--
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 16e3129db6a1..342edbd02880 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1469,6 +1469,41 @@ static int amdgpu_discovery_sysfs_recurse(struct a=
mdgpu_device *adev,
>         return 0;
>  }
>
> +#define list_to_kobj(el) container_of(el, struct kobject, entry)
> +
> +static void amdgpu_discovery_sysfs_update_harvest(struct amdgpu_device *=
adev)
> +{
> +       struct ip_discovery_top *ip_top =3D adev->discovery.ip_top;
> +       struct ip_die_entry *ip_die_entry;
> +       struct list_head *el_die, *el_hw_id, *el_hw_inst;
> +       struct ip_hw_id *hw_id;
> +       struct kset *die_kset;
> +       struct ip_hw_instance *ip_inst;
> +
> +       if (!ip_top)
> +               return;
> +
> +       die_kset =3D &ip_top->die_kset;
> +
> +       spin_lock(&die_kset->list_lock);
> +       list_for_each(el_die, &die_kset->list) {
> +               ip_die_entry =3D to_ip_die_entry(list_to_kobj(el_die));
> +
> +               list_for_each(el_hw_id, &ip_die_entry->ip_kset.list) {
> +                       hw_id =3D to_ip_hw_id(list_to_kobj(el_hw_id));
> +
> +                       list_for_each(el_hw_inst, &hw_id->hw_id_kset.list=
) {
> +                               ip_inst =3D to_ip_hw_instance(list_to_kob=
j(el_hw_inst));
> +                               ip_inst->harvest =3D
> +                                       amdgpu_discovery_get_harvest_info=
(
> +                                               adev, ip_inst->hw_id,
> +                                               ip_inst->num_instance);
> +                       }
> +               }
> +       }
> +       spin_unlock(&die_kset->list_lock);
> +}
> +
>  static int amdgpu_discovery_sysfs_init(struct amdgpu_device *adev)
>  {
>         uint8_t *discovery_bin =3D adev->discovery.bin;
> @@ -1479,9 +1514,13 @@ static int amdgpu_discovery_sysfs_init(struct amdg=
pu_device *adev)
>         if (!discovery_bin)
>                 return -EINVAL;
>
> -       /* If early init already created sysfs in standalone mode, skip n=
ormal init */
> -       if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_=
mode)
> +       /* If early init already created sysfs in standalone mode, update=
 harvest info
> +        * now that adev is fully initialized, then skip the rest of norm=
al init.
> +        */
> +       if (adev->discovery.ip_top && adev->discovery.ip_top->standalone_=
mode) {
> +               amdgpu_discovery_sysfs_update_harvest(adev);
>                 return 0;
> +       }
>
>         ip_top =3D kzalloc_obj(*ip_top);
>         if (!ip_top)
> @@ -1536,8 +1575,6 @@ static int amdgpu_discovery_sysfs_init(struct amdgp=
u_device *adev)
>
>  /* -------------------------------------------------- */
>
> -#define list_to_kobj(el) container_of(el, struct kobject, entry)
> -
>  static void amdgpu_discovery_sysfs_ip_hw_free(struct ip_hw_id *ip_hw_id)
>  {
>         struct list_head *el, *tmp;
> --
> 2.43.0
>
