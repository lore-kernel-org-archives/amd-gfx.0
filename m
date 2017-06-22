From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 1/3] drm/amdgpu: fix a typo
Date: Thu, 22 Jun 2017 18:24:23 +0200
Message-ID: <1d04c859-24c3-e1ec-1c68-50ffec512380@vodafone.de>
References: <1498099356-31332-1-git-send-email-AlexBin.Xie@amd.com>
 <5ff65f82-9d15-4606-7e25-e4f75c172aed@vodafone.de>
 <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0@DM5PR12MB1257.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0593040594=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Olsak, Marek" <Marek.Olsak-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0593040594==
Content-Type: multipart/alternative;
 boundary="------------DE43307B85F28EA30F471D34"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------DE43307B85F28EA30F471D34
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

yeah, the change looks totally ok to me. The problem is just that I'm 
not familiar with that part of the source.

Marek came up with that, so he should at least take a look and nod.

Regards,
Christian.

Am 22.06.2017 um 17:33 schrieb Xie, AlexBin:
>
> Hi Christian,
>
>
> In fact, the change from spinlock to atomic is quite painful. When I 
> started, I thought it was easy but later I found there might be race 
> condition here and there. Now I think the change looks more robust. In 
> kernel source, there are several other drivers used the same trick.
>
>
> On the other hand, I think the logic itself might be optimized 
> considering the locking. But I had spent quite some effort to maintain 
> original logic.
>
>
> Thanks,
>
> Alex Bin
>
>
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Thursday, June 22, 2017 3:35 AM
> *To:* Xie, AlexBin; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 1/3] drm/amdgpu: fix a typo
> Am 22.06.2017 um 04:42 schrieb Alex Xie:
> > Signed-off-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>
> With the commit message fixed as Michel suggested patches #1 and #2 are
> Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> as well.
>
> On patch #3 Marek needs to take a look, cause I don't know the logic
> behind that.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 7635f38..94c27fc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -494,7 +494,7 @@ static int amdgpu_cs_parser_bos(struct 
> amdgpu_cs_parser *p,
> > &e->user_invalidated) && e->user_pages) {
> >
> >                                /* We acquired a page array, but somebody
> > -                              * invalidated it. Free it an try again
> > +                              * invalidated it. Free it and try again
> >                                 */
> > release_pages(e->user_pages,
> > e->robj->tbo.ttm->num_pages,
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------DE43307B85F28EA30F471D34
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Alex,<br>
      <br>
      yeah, the change looks totally ok to me. The problem is just that
      I'm not familiar with that part of the source.<br>
      <br>
      Marek came up with that, so he should at least take a look and
      nod.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 22.06.2017 um 17:33 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1257B1FCC981D29A6D4045CDF2DB0-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p>Hi Christian,</p>
        <p><br>
        </p>
        <p>In fact, the change from spinlock to atomic is quite painful.
          When I started, I thought it was easy but later I found there
          might be race condition here and there. Now I think the change
          looks more robust. In kernel source, there are several other
          drivers used the same trick.</p>
        <p><br>
        </p>
        <p>On the other hand, I think the logic itself might be
          optimized considering the locking. But I had spent quite some
          effort to maintain original logic.<br>
        </p>
        <p><br>
        </p>
        <p>Thanks,</p>
        <p>Alex Bin<br>
        </p>
        <p><br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" face="Calibri, sans-serif"
                color="#000000"><b>From:</b> Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Thursday, June 22, 2017 3:35 AM<br>
                <b>To:</b> Xie, AlexBin; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH 1/3] drm/amdgpu: fix a typo</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 22.06.2017 um 04:42 schrieb Alex
                Xie:<br>
                &gt; Signed-off-by: Alex Xie <a class="moz-txt-link-rfc2396E" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">&lt;AlexBin.Xie-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                With the commit message fixed as Michel suggested
                patches #1 and #2 are <br>
                Reviewed-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> as well.<br>
                <br>
                On patch #3 Marek needs to take a look, cause I don't
                know the logic <br>
                behind that.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-<br>
                &gt;   1 file changed, 1 insertion(+), 1 deletion(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; index 7635f38..94c27fc 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
                &gt; @@ -494,7 +494,7 @@ static int
                amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,<br>
                &gt;                                
                &amp;e-&gt;user_invalidated) &amp;&amp;
                e-&gt;user_pages) {<br>
                &gt;   <br>
                &gt;                                /* We acquired a
                page array, but somebody<br>
                &gt; -                              * invalidated it.
                Free it an try again<br>
                &gt; +                              * invalidated it.
                Free it and try again<br>
                &gt;                                 */<br>
                &gt;                               
                release_pages(e-&gt;user_pages,<br>
                &gt;                                             
                e-&gt;robj-&gt;tbo.ttm-&gt;num_pages,<br>
                <br>
                <br>
              </div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------DE43307B85F28EA30F471D34--

--===============0593040594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0593040594==--
