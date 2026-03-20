Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA2D109446B
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEEAA10E36F;
	Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q5cWqo8N";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5942A10EAC1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 18:09:15 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-64e9f79cae8so1831795d50.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 11:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030154; cv=none;
 d=google.com; s=arc-20240605;
 b=LPgO4Hl+Fw+l9BOdEK9xv4im3/6b9Mm/8a3sZIG+a/vta2vkzonBexyssZPhZdJLct
 Me/cNOnpudYRlfUTfANyp6gfC68wlpnwKEmnd0kZPfsVm0Siy0Yvf9yF4wyLo/l3qjb7
 AOMmdEVwme4khQ7hz91PzldUo5L5z2FC4FXya//hzeLdvg4n6nGKPJ123/VTnSyJd2jc
 d1sLruRZ1wZFoTq13Z0bhewNT1So2u3Z/wfT+srMAc6zR7aYyGd6eKXzQHuGsINjh7wi
 3YetrDQcSpgAkmesCPmfE/i+OZ+w3E5s1PpPyQ5vuj7HEk34CmC6xyVp/b6esjlLl375
 /DnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 fh=Ywud+fR7cu7I1kzOQJWWDcGFmwMIUl4VF6EnlydgBp8=;
 b=a8FAS6wQjI9iToI3kqyD8KgnouRI7HC8GRIEBMQBNcWCa11RQCAtwsEwB2hnrpMM1F
 obSDVzxMnEiJdTw8tm5f6n++naJpQFAdhfmUkDKTc5WOVk1VpjTZ8XWZWG6el7gSqDo1
 /J2F80TwWC2DcIFKPnua+PGNdB8S9Ac+2SCoGR8SvepComwTCabCtyrN0Tz2dSZZmvVw
 dNxQ/OlOoeBMZXm3RcbcwDz8dePcytZysyFdqRLb0bE6E8uwWV26MntXV2WBrSTgyzZv
 Ld3QR2+ypF4fkeDNm7IdAdrCeqkzgjYoSJCtG0bcYIe8E7ncoLZXOydpRTAVXgim6cn2
 B1zQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030154; x=1774634954; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 b=Q5cWqo8NPQoOiU7mAU8XFfDwxfZn0n1os4c8lo4CjVg6z3QGqjnuewocQrW7pva4AU
 3N0/1040N9/YRnzd5M/x0CqKEEYoY9aKkk+k5+5cjGFjxgxVLpLwX3HqWa/XO7aC0dF9
 V8e7eOGIxFiOnTQKWN7yVnKT6KWfiweBRbAgcqhiwM5wDsySlyNRxumJ8vdmYPY1ef5G
 Ksf9TzAEmV/v2CyQiyBJsfw+DexSg1VBJ9mGNwum+qZQVMvBOKqA9bpwPLbo+Tja4FlG
 6y6B6VxvTAWVCuvqjcLVXVPhXeNv+KLMyDvDjKbCDBDJCXcPTVz1v49+iP98Os+BdfBw
 j5fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030154; x=1774634954;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AWhS4iaGoaPOka2Ug+rWFyTKYlbaHwFlyjwq3H7YvsM=;
 b=C4dU7j+8Lwh+DKMIsEP9BpATZ/pbTQYi3o68e/OVZWgfD3bdU2Q0SIDvNNkBY8lris
 7mrhRleT1skJluwh5arzBI/NE86IXAcZNd6w7aKDYqDQneOXPIS0BvI6ZWOa0K9zAYWd
 wzzCrhwQt6jRaLe5ywpGePbpWdRw9dJX53uF4CKpsUvThPi9SzRFeZt3omuo1VowPwCl
 FkI6lGk6Z2gC3DYXCZLtexh//7ju4pBFwTYCclgQETo+crce/Q3T/ASfwj/k9BZFDiKc
 7eI3UdfDgX0RvgKLzrVosSHERsrkVqavubuwoAvq+6cIvu8H6JuccYEN1AkA8URVB7q8
 62yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQ3H4nFGcj4W17XMGs2X14E3M/0/EMF4PaMgebQjvInnkBqBLj1SIRQzBo6+agHZw/CKn9nQnL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPsrtX+5Vr2vuz3yl6gFhjNW7Y3MCRD7lMrtqxPrjZIhBRHsYT
 aETnLS4QN9zO9T7YUUnsa3VRMMvdKURvpZ716Rb0JrZFU+vnkU1Ukv43DzpT4IdM4KZB2xNbRHa
 4NpxJPZRtZa1XAd6ahpol3FyM8ZKIRQ8=
X-Gm-Gg: ATEYQzwFNB6j5Osmt9bmjnWTDgT8If4oVmFrSlrey2pGqWSB3VXsxC9QVjVK0EKMU+c
 zn5xdNpXSDeAr7m59mvbXE1uzUoH6zCXNwdYECzaqYHWXmN6/q8UPw5oRzYJBUD/+nwPZFdqQpM
 +9h27BY6gfZvFJdzHANFLTFaJDjSxharV+ssxkBMcX5QHy2QAOIyoUM9BDEZK8XR7uSxbsxBOaW
 NhufJBR8MaZadt2NjV4oJVa2swsoLou5I4HrTr2faAFydF7r0JV90Ketcdz7/aBcXJcI1MS2SJB
 ZsYI
X-Received: by 2002:a53:d7c8:0:b0:64c:f90c:743b with SMTP id
 956f58d0204a3-64eaa764fe2mr3121177d50.41.1774030154371; Fri, 20 Mar 2026
 11:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-33-jim.cromie@gmail.com>
 <177402491454.6181.12972283720507136037.b4-review@b4>
In-Reply-To: <177402491454.6181.12972283720507136037.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:08:48 -0600
X-Gm-Features: AaiRm52OI33ofFnw-Ol-4xRbb4iS7hd6Ofimy35v4GvSaV31JzwNtCu7GJCPT2U
Message-ID: <CAJfuBxwnKXG4d92WOOpiXRDXjFrYFnvfbKXaG5nn4nm4pVyqdQ@mail.gmail.com>
Subject: Re: [PATCH v11 32/65] dyndbg: Harden classmap and callsite validation
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:57 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 0d1245aefc69..28684cfc0937 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -262,6 +262,8 @@ struct _ddebug_class_param {
> >
> >  #define __DYNAMIC_DEBUG_CLASSMAP_USE(_var, _offset, _uname)          \
> >       extern struct _ddebug_class_map _var;                           \
> > +     static_assert((_offset) >=3D 0 && (_offset) < _DPRINTK_CLASS_DFLT=
, \
> > +                   "classmap use offset must be in 0..62");          \
>
> Can't you also check the offset+base?

If I dont already check, I can. theyre all constants.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 2083a8546460..635df6edb4cf 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1404,9 +1404,8 @@ static void ddebug_apply_class_users(const struct=
 _ddebug_info *di)
> >       (__dst)->info._vec.len =3D __nc;                                 =
 \
> >  })
> >
> > -static int __maybe_unused
> > -ddebug_class_range_overlap(struct _ddebug_class_map *cm,
> > -                        u64 *reserved_ids)
> > +static int ddebug_class_range_overlap(struct _ddebug_class_map *cm,
> > +                                   u64 *reserved_ids)
>
> I think you can remove the __maybe_unused earlier in the series (23/65
> seems to use it).

yeah that sounds correct.

>
> > @@ -1454,10 +1471,33 @@ static int ddebug_add_module(struct _ddebug_inf=
o *di)
> > [ ... skip 5 lines ... ]
> > +     /* validate class map types and the per-module 0..62 class_id spa=
ce */
> > +     for_subvec(i, cm, &dt->info, maps) {
> > +             if (cm->map_type > DD_CLASS_TYPE_LEVEL_NUM) {
> > +                     pr_err("module %s has unknown classmap type %d\n"=
, dt->info.mod_name, cm->map_type);
> > +                     goto cleanup;
> > +             }
>
> I think this check could be inserted earlier.

ya this could be compile-time too.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
