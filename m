Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE33C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 16:28:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA4E610EF00;
	Wed,  1 Jun 2022 16:27:59 +0000 (UTC)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69D6510EF00
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 16:27:58 +0000 (UTC)
Received: by mail-pg1-x52f.google.com with SMTP id v15so2342354pgk.11
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RbtitoVm/9KATujxKlgzFkfn/LEN8Z8uXxXZpN/5gxg=;
 b=kON1wdS9cnYeCYpOosOPlF6HjScL/fV0m+3yHvqYQZLgTY+zVQAA2VbR9JUsTSgPLB
 JdHuScqKmnZoiyK4+RN5llgt1jvz4677YM7l5iR5aQTtSUzFf4K9dlVFeTLkab/BtDBk
 VdZQKkURkdBI5ovq8kLZEhpJzEzHYr4tAIjA3TP+WepUbIL3GoaQMJMDcWocODNRzTRU
 E9O8cWX9d9RcEyCHKxaNrzKFOnPyFH1NfZ8Rz8LxBdRuETvV74PydOW57pu1zRIn9OU2
 3HFisNendwKVe0WvGehMumVD055KrO0YS0qj6AAE6H/cgi33zRs0DUw1CAkFFoT4sZsh
 ChlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RbtitoVm/9KATujxKlgzFkfn/LEN8Z8uXxXZpN/5gxg=;
 b=NdQpcqbaZxGcajsf+Pj5fSKu6T0OZ4imp0ne+BncWT+SUjQaBdfGfouzjLwcSrocyE
 4pDxV82QVIOYBQJIhcJ7BOiC546WXO1PwEHTU/2Ttwl9TinHieR8j/EISoEu3i0PGFb6
 Qeo5L68nDKLYktbPncubQMApsHD29c7HqxFasuWDoChvj0H6uFmwsW1zpic8WkFvmQ08
 B2Zw+fTvatBr3AofBYh77WIt+PlDkpU7R+0C2/3bioPqOm3EJWByTBPv9ecNXuqdlJUk
 tk9M+o/C9wJ/Obz9AV1+P1GjACYXrng63ftbmcxpr1ZBfQ/Xwbytr11AK92wmRR2slmR
 L+vQ==
X-Gm-Message-State: AOAM530uhsDMObOzbvc11J0dhIervKwe2aPL1yB97orKj14PY2xhXeqN
 93xEIhu8rgfZDTTxm+tkT6cJNmjsgjm1GJT6iKXoPUHy
X-Google-Smtp-Source: ABdhPJzoTt6KWst9tG9CCXGLF/LTyKAFcduFiWusVhlw6ddZBsWrR4tUcO0Iq1l8BnLnFSfglGGow4y8cOSUMMzkop0=
X-Received: by 2002:a63:82c7:0:b0:3fc:bcd9:8114 with SMTP id
 w190-20020a6382c7000000b003fcbcd98114mr217791pgd.112.1654100878031; Wed, 01
 Jun 2022 09:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
In-Reply-To: <293d9f72-c3e5-913d-08d1-0a8591299c46@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 1 Jun 2022 12:27:22 -0400
Message-ID: <CAAxE2A5Apz3u7cxCcpPuhYDj=s2Jg2vwd=2jhXbnR=3X8ZWxFw@mail.gmail.com>
Subject: Re: Explicit VM updates
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/alternative; boundary="00000000000042010905e0655fde"
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000042010905e0655fde
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you please summarize what this is about?

Thanks,
Marek

On Wed, Jun 1, 2022 at 8:40 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om>
wrote:

> Hey guys,
>
> so today Bas came up with a new requirement regarding the explicit
> synchronization to VM updates and a bunch of prototype patches.
>
> I've been thinking about that stuff for quite some time before, but to
> be honest it's one of the most trickiest parts of the driver.
>
> So my current thinking is that we could potentially handle those
> requirements like this:
>
> 1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. This
> way we either get the new behavior for the whole CS+VM or the old one,
> but never both mixed.
>
> 2. When memory is unmapped we keep around the last unmap operation
> inside the bo_va.
>
> 3. When memory is freed we add all the CS fences which could access that
> memory + the last unmap operation as BOOKKEEP fences to the BO and as
> mandatory sync fence to the VM.
>
> Memory freed either because of an eviction or because of userspace
> closing the handle will be seen as a combination of unmap+free.
>
>
> The result is the following semantic for userspace to avoid implicit
> synchronization as much as possible:
>
> 1. When you allocate and map memory it is mandatory to either wait for
> the mapping operation to complete or to add it as dependency for your CS.
>      If this isn't followed the application will run into CS faults
> (that's what we pretty much already implemented).
>
> 2. When memory is freed you must unmap that memory first and then wait
> for this unmap operation to complete before freeing the memory.
>      If this isn't followed the kernel will add a forcefully wait to the
> next CS to block until the unmap is completed.
>
> 3. All VM operations requested by userspace will still be executed in
> order, e.g. we can't run unmap + map in parallel or something like this.
>
> Is that something you guys can live with? As far as I can see it should
> give you the maximum freedom possible, but is still doable.
>
> Regards,
> Christian.
>

--00000000000042010905e0655fde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Can you please summarize what this is about?</div><di=
v><br></div><div>Thanks,</div><div>Marek<br></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 1, 2022 at 8:=
40 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">=
christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">Hey guys,<br>
<br>
so today Bas came up with a new requirement regarding the explicit <br>
synchronization to VM updates and a bunch of prototype patches.<br>
<br>
I&#39;ve been thinking about that stuff for quite some time before, but to =
<br>
be honest it&#39;s one of the most trickiest parts of the driver.<br>
<br>
So my current thinking is that we could potentially handle those <br>
requirements like this:<br>
<br>
1. We add some new EXPLICIT flag to context (or CS?) and VM IOCTL. This <br=
>
way we either get the new behavior for the whole CS+VM or the old one, <br>
but never both mixed.<br>
<br>
2. When memory is unmapped we keep around the last unmap operation <br>
inside the bo_va.<br>
<br>
3. When memory is freed we add all the CS fences which could access that <b=
r>
memory + the last unmap operation as BOOKKEEP fences to the BO and as <br>
mandatory sync fence to the VM.<br>
<br>
Memory freed either because of an eviction or because of userspace <br>
closing the handle will be seen as a combination of unmap+free.<br>
<br>
<br>
The result is the following semantic for userspace to avoid implicit <br>
synchronization as much as possible:<br>
<br>
1. When you allocate and map memory it is mandatory to either wait for <br>
the mapping operation to complete or to add it as dependency for your CS.<b=
r>
=C2=A0=C2=A0=C2=A0=C2=A0 If this isn&#39;t followed the application will ru=
n into CS faults <br>
(that&#39;s what we pretty much already implemented).<br>
<br>
2. When memory is freed you must unmap that memory first and then wait <br>
for this unmap operation to complete before freeing the memory.<br>
=C2=A0=C2=A0=C2=A0=C2=A0 If this isn&#39;t followed the kernel will add a f=
orcefully wait to the <br>
next CS to block until the unmap is completed.<br>
<br>
3. All VM operations requested by userspace will still be executed in <br>
order, e.g. we can&#39;t run unmap + map in parallel or something like this=
.<br>
<br>
Is that something you guys can live with? As far as I can see it should <br=
>
give you the maximum freedom possible, but is still doable.<br>
<br>
Regards,<br>
Christian.<br>
</blockquote></div>

--00000000000042010905e0655fde--
