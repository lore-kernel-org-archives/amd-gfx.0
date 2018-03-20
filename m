From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 20 Mar 2018 14:55:10 +0100
Message-ID: <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
 <BY1PR12MB0504183ED35A54559D22E041F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>
 <BY1PR12MB05044A2A50F2580904C8AFB5F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0326218772=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, "Li,
 Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0326218772==
Content-Type: multipart/alternative;
 boundary="------------E68D74931A319D90A144AA46"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E68D74931A319D90A144AA46
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, exactly. And if I remember correctly Mesa used to always set GTT as 
fallback on APUs, correct?

The problem seems to be that this fallback isn't set for displayable BOs.

So what needs to be done is to just enable this fallback for displayable 
BOs as well if the kernel can handle it.

Christian.

Am 20.03.2018 um 00:01 schrieb Marek Olšák:
> In theory, Mesa doesn't have to do anything. It can continue setting 
> VRAM and if the kernel has to put a display buffer into GTT, it 
> doesn't matter (for Mesa). Whether the VRAM placement is really used 
> is largely determined by BO priorities.
>
> The way I understand scather/gather is that it only allows the GTT 
> placement. It doesn't force the GTT placement. Mesa also doesn't force 
> the GTT placement.
>
> Marek
>
> On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org
>     <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>> wrote:
>     >>to my earlier point, there may be cases where it is advantageous
>     to put
>     >> display buffers in vram even if s/g display is supported
>     >
>     > Agreed. That is also why the patch has the options to let user
>     select where
>     > to put display buffers.
>     >
>     > As whether to put the option in Mesa or kernel, it seems the
>     difference is
>     > not much. Also, since amdgpufb can request even without mesa,
>     kernel might
>     > be a better choice. In addition, putting in the kernel can save
>     client’s
>     > duplicate work(mesa, ogl, vulkan, 2d, kernel…)
>
>     Why do we even expose different memory pools to the UMDs in the first
>     place ;)  Each pool has performance characteristics that may be
>     relevant for a particular work load.  Only the UMDs really know the
>     finer points of those workloads. In general, you don't want the kernel
>     dictating policy if you can avoid it.  The kernel exposes
>     functionality and userspace sets the policy.  With the location set in
>     userspace, each app/user can have whatever policy makes sense for
>     their use case all at the same time without needing to tweak their
>     kernel for every use case.
>
>     Alex
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------E68D74931A319D90A144AA46
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Yes, exactly. And if I remember
      correctly Mesa used to always set GTT as fallback on APUs,
      correct?<br>
      <br>
      The problem seems to be that this fallback isn't set for
      displayable BOs.<br>
      <br>
      So what needs to be done is to just enable this fallback for
      displayable BOs as well if the kernel can handle it.<br>
      <br>
      Christian.<br>
      <br>
      Am 20.03.2018 um 00:01 schrieb Marek Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_extra">
          <div class="gmail_quote">In theory, Mesa doesn't have to do
            anything. It can continue setting VRAM and if the kernel has
            to put a display buffer into GTT, it doesn't matter (for
            Mesa). Whether the VRAM placement is really used is largely
            determined by BO priorities.<br>
          </div>
          <div class="gmail_quote"><br>
          </div>
          <div class="gmail_quote">The way I understand scather/gather
            is that it only allows the GTT placement. It doesn't force
            the GTT placement. Mesa also doesn't force the GTT
            placement.<br>
          </div>
          <div class="gmail_quote"><br>
          </div>
          <div class="gmail_quote">Marek<br>
          </div>
          <div class="gmail_quote"><br>
          </div>
          <div class="gmail_quote">On Mon, Mar 19, 2018 at 5:12 PM, Alex
            Deucher <span dir="ltr">&lt;<a
                href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank"
                moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
            wrote:<br>
            <blockquote class="gmail_quote" style="margin:0 0 0
              .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>On
                Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel &lt;<a
                  href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org" target="_blank"
                  moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;
                wrote:<br>
                &gt;&gt;to my earlier point, there may be cases where it
                is advantageous to put<br>
                &gt;&gt; display buffers in vram even if s/g display is
                supported<br>
                &gt;<br>
                &gt; Agreed. That is also why the patch has the options
                to let user select where<br>
                &gt; to put display buffers.<br>
                &gt;<br>
                &gt; As whether to put the option in Mesa or kernel, it
                seems the difference is<br>
                &gt; not much. Also, since amdgpufb can request even
                without mesa, kernel might<br>
                &gt; be a better choice. In addition, putting in the
                kernel can save client’s<br>
                &gt; duplicate work(mesa, ogl, vulkan, 2d, kernel…)<br>
                <br>
              </span>Why do we even expose different memory pools to the
              UMDs in the first<br>
              place ;)  Each pool has performance characteristics that
              may be<br>
              relevant for a particular work load.  Only the UMDs really
              know the<br>
              finer points of those workloads. In general, you don't
              want the kernel<br>
              dictating policy if you can avoid it.  The kernel exposes<br>
              functionality and userspace sets the policy.  With the
              location set in<br>
              userspace, each app/user can have whatever policy makes
              sense for<br>
              their use case all at the same time without needing to
              tweak their<br>
              kernel for every use case.<br>
              <span class="m_4947926278827078055HOEnZb"><font
                  color="#888888"><br>
                  Alex</font></span><br>
            </blockquote>
          </div>
        </div>
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
    <br>
  </body>
</html>

--------------E68D74931A319D90A144AA46--

--===============0326218772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0326218772==--
