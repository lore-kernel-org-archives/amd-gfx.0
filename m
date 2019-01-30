From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add AMDGPU_IB_FLAG_GET_START_SYNCOBJ to
 expose scheduled fence
Date: Wed, 30 Jan 2019 09:19:32 +0100
Message-ID: <43ab9bb4-03a6-8837-8015-270f55e9418e@gmail.com>
References: <20190128215239.32498-1-maraeo@gmail.com>
 <762485e9-7fe4-3ffb-16a4-f83436871451@gmail.com>
 <CAAxE2A4GaY4-osO6GfC-zG9ofxu2wjWZJ74Jds1ntqXZba_vQw@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1683529961=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4GaY4-osO6GfC-zG9ofxu2wjWZJ74Jds1ntqXZba_vQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1683529961==
Content-Type: multipart/alternative;
 boundary="------------552250F3AFDEE0B8DFA3C035"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------552250F3AFDEE0B8DFA3C035
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 29.01.19 um 22:54 schrieb Marek Olšák:
> On Tue, Jan 29, 2019 at 3:01 AM Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Am 28.01.19 um 22:52 schrieb Marek Olšák:
>     > From: Marek Olšák <marek.olsak-5C7GfCeVMHo@public.gmane.org <mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org>>
>     >
>     > Normal syncobjs signal when an IB finishes. Start syncobjs
>     signal when
>     > an IB starts.
>
>     That approach has quite a number of problems (for example you can't
>     allocate memory at this point).
>
>
> Even if I drop this patch, can you describe all the problems with it? 
> Andrey and I would like to understand this.

> amdgpu_mn_lock(p->mn);
> ...
> r = drm_syncobj_create(&syncobj, 0,...

You can't allocate memory while holding the MN lock, so calling 
drm_syncobj_create() here is forbidden.

> r = drm_syncobj_get_handle(p->filp, syncobj,...

This can fail which would result in a syncobj which is never signaled 
nor freed.

Regards,
Christian.

>
> Thanks,
> Marek
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------552250F3AFDEE0B8DFA3C035
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 29.01.19 um 22:54 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4GaY4-osO6GfC-zG9ofxu2wjWZJ74Jds1ntqXZba_vQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Tue, Jan 29, 2019 at 3:01
            AM Christian König &lt;<a
              href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
              target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 28.01.19 um 22:52
            schrieb Marek Olšák:<br>
            &gt; From: Marek Olšák &lt;<a
              href="mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org" target="_blank"
              moz-do-not-send="true">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
            &gt;<br>
            &gt; Normal syncobjs signal when an IB finishes. Start
            syncobjs signal when<br>
            &gt; an IB starts.<br>
            <br>
            That approach has quite a number of problems (for example
            you can't <br>
            allocate memory at this point).<br>
          </blockquote>
          <div><br>
          </div>
          <div>Even if I drop this patch, can you describe all the
            problems with it? Andrey and I would like to understand
            this.<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <blockquote type="cite">amdgpu_mn_lock(p-&gt;mn);<br>
      ...<br>
      r = drm_syncobj_create(&amp;syncobj, 0,...<br>
    </blockquote>
    <br>
    You can't allocate memory while holding the MN lock, so calling
    drm_syncobj_create() here is forbidden.<br>
    <br>
    <blockquote type="cite">r = drm_syncobj_get_handle(p-&gt;filp,
      syncobj,...<br>
    </blockquote>
    <br>
    This can fail which would result in a syncobj which is never
    signaled nor freed.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAxE2A4GaY4-osO6GfC-zG9ofxu2wjWZJ74Jds1ntqXZba_vQw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div><br>
          </div>
          <div>Thanks,</div>
          <div>Marek</div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------552250F3AFDEE0B8DFA3C035--

--===============1683529961==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1683529961==--
