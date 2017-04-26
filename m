From: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix gpu reset crash
Date: Wed, 26 Apr 2017 12:57:22 +0800
Message-ID: <590028B2.6040503@amd.com>
References: <1493026850-29604-1-git-send-email-David1.Zhou@amd.com>
 <a43a71f9-b8b1-4ff3-3532-d13bdd539761@vodafone.de> <58FEB257.2010002@amd.com>
 <BN6PR12MB1652CAFE2B4D576733D2EBA3F71E0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0007599913=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1652CAFE2B4D576733D2EBA3F71E0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?Q2hyaXN0aQ==?= =?UTF-8?B?YW4gS8O2bmln?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0007599913==
Content-Type: multipart/alternative;
	boundary="------------030402040802080303060005"

--------------030402040802080303060005
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit



On 2017年04月25日 21:34, Deucher, Alexander wrote:
> > -----Original Message-----
> > From: amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org] On Behalf
> > Of zhoucm1
> > Sent: Monday, April 24, 2017 10:20 PM
> > To: Christian König; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > Subject: Re: [PATCH 1/2] drm/amdgpu: fix gpu reset crash
> >
> >
> >
> > On 2017年04月24日 17:47, Christian König wrote:
> > >> The root cause is some ring doesn't have scheduler, like KIQ ring
> > >>
> > >> Change-Id: I420e84add9cdd9a7fd1f9921b8a5d0afa3dd2058
> > >> Signed-off-by: Chunming Zhou <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
> > >
> > > Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org> for both.
> > I forgot to add RB when pushing patches, How can I add it again?
>
> I'll add it before sending upstream.
Thanks.

David
>
> Alex
>
> >
> > Sorry for that.
> > David Zhou
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------030402040802080303060005
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <br>
    <br>
    <div class="moz-cite-prefix">On 2017年04月25日 21:34, Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote
cite="mid:BN6PR12MB1652CAFE2B4D576733D2EBA3F71E0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">&gt; -----Original Message-----<br>
            &gt; From: amd-gfx [<a moz-do-not-send="true"
              href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
            On Behalf<br>
            &gt; Of zhoucm1<br>
            &gt; Sent: Monday, April 24, 2017 10:20 PM<br>
            &gt; To: Christian König; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; Subject: Re: [PATCH 1/2] drm/amdgpu: fix gpu reset
            crash<br>
            &gt; <br>
            &gt; <br>
            &gt; <br>
            &gt; On 2017年04月24日 17:47, Christian König wrote:<br>
            &gt; &gt;&gt; The root cause is some ring doesn't have
            scheduler, like KIQ ring<br>
            &gt; &gt;&gt;<br>
            &gt; &gt;&gt; Change-Id:
            I420e84add9cdd9a7fd1f9921b8a5d0afa3dd2058<br>
            &gt; &gt;&gt; Signed-off-by: Chunming Zhou
            <a class="moz-txt-link-rfc2396E" href="mailto:David1.Zhou-5C7GfCeVMHo@public.gmane.org">&lt;David1.Zhou-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; &gt;<br>
            &gt; &gt; Reviewed-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> for both.<br>
            &gt; I forgot to add RB when pushing patches, How can I add
            it again?<br>
            <br>
            I'll add it before sending upstream.<br>
          </div>
        </span></font></blockquote>
    <font size="2">Thanks.<br>
      <br>
      David<br>
    </font>
    <blockquote
cite="mid:BN6PR12MB1652CAFE2B4D576733D2EBA3F71E0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite"><font size="2"><span style="font-size:10pt;">
          <div class="PlainText">
            <br>
            Alex<br>
            <br>
            &gt; <br>
            &gt; Sorry for that.<br>
            &gt; David Zhou<br>
            &gt; _______________________________________________<br>
            &gt; amd-gfx mailing list<br>
            &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
    </blockquote>
    <br>
  </body>
</html>

--------------030402040802080303060005--

--===============0007599913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0007599913==--
