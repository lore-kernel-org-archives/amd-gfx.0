Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18931094467
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC6F310E2EE;
	Sat, 21 Mar 2026 09:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HgNFAUq0";
	dkim-atps=neutral
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com
 [74.125.224.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C2D10EACB
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 18:15:51 +0000 (UTC)
Received: by mail-yx1-f52.google.com with SMTP id
 956f58d0204a3-64e8c7f5082so2036225d50.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 11:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774030551; cv=none;
 d=google.com; s=arc-20240605;
 b=GMBJgMhlpaM1Y3gyR5Y/gWd4hUxs0/gBdmVVE6SZNUDSDdyUAC1WjgTbpfDGifS7d0
 p2c5W4JWF80NkuJWJFfC6ANy7vvGZPLMDsAuWol4/inoKIrEWcaTgvCqUltnvKsBj44I
 CCUM1NoCmyThOhCfd62s5xYTR7WPRIzStGupdCZZ56PyZKEek61BRZsZ08JTEo7nzvjO
 RJVUl6RbIMEVX265pMimXjMoD7iJOa68HrkMgx3pcF/K2lLaJh/fDgMrMVqV1PuKmz6/
 5aKnronAMw9ldkMWPH/ED11FTe1W63fUvRI3UzaYgFLhrv6Y5kcAFDyJ9cuM3JYk8gB5
 6w6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 fh=Nu1Hk+DvYGUu/pNVcFsfgfIWijg3q2rqfAvSnyhKb4A=;
 b=is2c7xSI6FHG9+PBl6GfX+WBLakazP0aQpovAoJ2hK42p5JDNCDoVT0Y4oMP8ycxVL
 8A3OJs1WAJdh0hKXJ/f7Mvj9q84ETFn3eOaOu40lmL4k/yZxFHaWjkW8QcZYDMzJGC+R
 nx4r/ZV04IeIJGewOzuQXJXWdxXBO9HOMeoAZ+91ZHmQCCpXygomYpUt+w4ShcvQ7+bE
 Ka9ILUwExCFZBSzEU6V4Vfy1S/65q9kkxs7IIl+pWwCqefKCZ3mTBO4lVIg8h/qZZN3P
 pEWDEACnqpiK4s2tIy97lsX7RZHWcZM/0wDep4JzeAqrbsEhim3QvA6HOO4bhzxyN4+H
 SiqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774030551; x=1774635351; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 b=HgNFAUq0Hgyiw4zqw3JgpV0k0nbDWJydu24VMfUWtYQna+PmQ6RaWNYT/uWn00NVAi
 soJwDvNOzhXjPxepn/j32sje7SpaG+PvCuTe82490IjW1mRurXGcEU2t1Tfx4bbY8bTv
 yObon8XLsqbwtWFCKC6z4IBMs2+zqYMHVrVfdm7JndzaopaWHlDf/2CgiOMS4XOJJ5+T
 aFJimKhyY9IcRVSx3fr37rzLUYzsk9QWoKU8PBLlts4rMODpi6S4L9clcKak8LddQf2l
 EhKypPRVIsoHOyncX80e9DgR/hdbxavjR1HXTZkguvE1e9h5O/zAy61uYwMfUM4W6g8m
 Mb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774030551; x=1774635351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yqVOmyZ2Z9NpjvmKpf4W2/OoeWedoqj5iVulCJB7QGg=;
 b=oNfWaqWhbNtj0L6lr02a8WVQJym7zggUtSK7CYMGNRLLCUEAuyG30Oj2jL6fEjy78L
 x+DSUDcZReJHNLei95Xa0byxYJ9Z6YTGZOUIJvzV8H0/vlPtq1k7iWwnk3WgJggJ/0/2
 FYWAFpaJG3FYv+EDYGBmowpFY7YlAflSo51VGl0oGBTfKFHAFIIJYTczWCfjbRd97Tcv
 BRAQkUswLL+4dDrZ+m//PR7ulxIdK1e9Qrm9FMrEc2ysCcV9StxKYsvY0ne/hj3ZY3Gt
 x4iAH0jkAOSzXYrCQ2MNjL49dIgmqz7NUQjftOQZoraftu7ylxEleSeevaM9O7AOWWze
 MmLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFiyUDwxp7eS6fSt9/obeoEraAYuB/5aU70hzIfaXnoH3wAwOsVgrTGdmVC3ejwZEGgXVw7FXu@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw75tNAjaPmWmUpALHt/Fk81gxpTL21ck/94VNTzSCYWtz6+ZSC
 sqGvT5XZJEpegq2pqpJWnzINzahTDpxp7Fp2K/8q4jHG9kQrH8KaO8cXo7ehlzX9ZajsJQTgXfB
 yRDBL7dEJSREu3pSZpVe3XGHigXUbhT8=
X-Gm-Gg: ATEYQzwJlObwxvv/OjyC/FI5q/AsEwWpkpuQ3/UgUk6Rb5onH0yDtvv7HbxzIsrJOVj
 E6tbyOnISbxinQTaf6eV8+R4qPYrV09l48fnpZVAD7cjPup04f+jY/TWBVxUJClPiICFB1qs+rX
 4nbcs/8rzWHnrCIMJWBI+48NkiMGfRtcxWuc5Z3wE4Em74v1K4599VmKiyV5c4aGIEKyxkrUd4k
 cS82kjXC9HoBJodrDvSTlSk7wr9hSLKt5gy9vtmc48AAvhDs5Rwhl8Ss0lHZJywzIu3fxEXH3gn
 x5AT
X-Received: by 2002:a53:c052:0:10b0:64e:a220:295c with SMTP id
 956f58d0204a3-64eaa6de30amr3530515d50.23.1774030550487; Fri, 20 Mar 2026
 11:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-34-jim.cromie@gmail.com>
 <177402491455.6181.14143715499365255565.b4-review@b4>
In-Reply-To: <177402491455.6181.14143715499365255565.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:15:24 -0600
X-Gm-Features: AaiRm50oHJtX5DOcrlwYqkPT1yywLsHi6Mo-IWiyIyjkVSYXdjkPbyeG6tTGqzc
Message-ID: <CAJfuBxxJBPxG9uYp2XrKF4952ika8AitSUq=ExT0N+_VZqKEAg@mail.gmail.com>
Subject: Re: [PATCH v11 33/65] docs/dyndbg: add classmap info to howto
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
> On Fri, 13 Mar 2026 07:19:58 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Docume=
ntation/admin-guide/dynamic-debug-howto.rst
> > index 0a42b9de55ac..734be0b5fe9a 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -218,6 +211,25 @@ line
> > [ ... skip 13 lines ... ]
> > +
> > +.. note::
> > +
> > +    Unlike other keywords, classes are "name-to-change", not
> > +    "omitting-constraint-allows-change".  See Dynamic Debug Classmaps
> > +
>
> Why did you move the class description?
> Is there a way to add a link to _dyndbg-classmaps? (I don't know well the
> rst syntax)

I think I moved it to the bottom cuz its the latest keyword, and the
longest description.
(theyre not alphabetical, they could be, should they be ?)


>
> > @@ -395,3 +412,98 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``=
.
> > [ ... skip 45 lines ... ]
> > +DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this map=
s
> > +classnames (a list of strings) onto class-ids consecutively, starting
> > +at _base.
> > +
> > +DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
> > +call this to refer to the var _DEFINEd elsewhere (and exported).
>
> (if you reorder the patches to merge the "basic" stuff, don't forget to
> move the _USE_ and offset explaination in a second documentation patch)
>
> Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
