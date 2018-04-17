From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to SRIOV
Date: Tue, 17 Apr 2018 17:26:41 +0200
Message-ID: <0cf6dae0-afae-c858-73af-ab47673a7d8a@gmail.com>
References: <20180417130135.1895-1-christian.koenig@amd.com>
 <DM5PR12MB1820165CD71A527EAA47C5F4F7B70@DM5PR12MB1820.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0389292229=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1820165CD71A527EAA47C5F4F7B70-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deng, Emily" <Emily.Deng-5C7GfCeVMHo@public.gmane.org>, "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0389292229==
Content-Type: multipart/alternative;
 boundary="------------BCB105D82FA74AF6D71744BF"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------BCB105D82FA74AF6D71744BF
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> Does this actually work on SR-IOV? Or does it just seem to but nothing 
> bad happens because we get a GPU reset on a world switch?
I honestly don't know. I think that SR-IOV uses a specialized firmware 
where this packet has a different meaning.

But the real fix would be to get the RLC firmware fix to not 
reinitialize those regs to zero on world switch.

Christian.

Am 17.04.2018 um 16:02 schrieb Deucher, Alexander:
>
> Does this actually work on SR-IOV?  Or does it just seem to but 
> nothing bad happens because we get a GPU reset on a world switch?  The 
> behavior of this packet should be the same as SDMA and that definitely 
> doesn't work.  I don't see why this would be any different.
>
>
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Tuesday, April 17, 2018 9:01:35 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* [PATCH] drm/amdgpu: limit reg_write_reg_wait workaround to 
> SRIOV
> Turned out that this locks up some bare metal Vega10.
>
> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 583f6f616dd3..5329d7e5fb71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4144,7 +4144,12 @@ static void 
> gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
>  {
>          int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
>
> -       gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1, ref, 
> mask, 0x20);
> +       if (amdgpu_sriov_vf(adev))
> +               gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1,
> +                                     ref, mask, 0x20);
> +       else
> + amdgpu_ring_emit_reg_write_reg_wait_helper(ring, reg0, reg1,
> + ref, mask);
>  }
>
>  static void gfx_v9_0_set_gfx_eop_interrupt_state(struct amdgpu_device 
> *adev,
> -- 
> 2.14.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------BCB105D82FA74AF6D71744BF
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">Does this actually work on SR-IOV? Or does
        it just seem to but nothing bad happens because we get a GPU
        reset on a world switch?<br>
      </blockquote>
      I honestly don't know. I think that SR-IOV uses a specialized
      firmware where this packet has a different meaning.<br>
      <br>
      But the real fix would be to get the RLC firmware fix to not
      reinitialize those regs to zero on world switch.<br>
      <br>
      Christian.<br>
      <br>
      Am 17.04.2018 um 16:02 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1820165CD71A527EAA47C5F4F7B70-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Does this actually work
          on SR-IOV?  Or does it just seem to but nothing bad happens
          because we get a GPU reset on a world switch?  The behavior of
          this packet should be the same as SDMA and that definitely
          doesn't work.  I don't see why this would be any different.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Acked-by: Alex Deucher
          <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Alex<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Christian König
          <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Tuesday, April 17, 2018 9:01:35 AM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Subject:</b> [PATCH] drm/amdgpu: limit reg_write_reg_wait
          workaround to SRIOV</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Turned out that this locks up some
              bare metal Vega10.<br>
              <br>
              Signed-off-by: Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 7 ++++++-<br>
               1 file changed, 6 insertions(+), 1 deletion(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
              b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              index 583f6f616dd3..5329d7e5fb71 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              @@ -4144,7 +4144,12 @@ static void
              gfx_v9_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring
              *ring,<br>
               {<br>
                       int usepfp = (ring-&gt;funcs-&gt;type ==
              AMDGPU_RING_TYPE_GFX);<br>
               <br>
              -       gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1, reg0,
              reg1, ref, mask, 0x20);<br>
              +       if (amdgpu_sriov_vf(adev))<br>
              +               gfx_v9_0_wait_reg_mem(ring, usepfp, 0, 1,
              reg0, reg1,<br>
              +                                     ref, mask, 0x20);<br>
              +       else<br>
              +              
              amdgpu_ring_emit_reg_write_reg_wait_helper(ring, reg0,
              reg1,<br>
              +                                                         
              ref, mask);<br>
               }<br>
               <br>
               static void gfx_v9_0_set_gfx_eop_interrupt_state(struct
              amdgpu_device *adev,<br>
              -- <br>
              2.14.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
    </blockquote>
    <br>
  </body>
</html>

--------------BCB105D82FA74AF6D71744BF--

--===============0389292229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0389292229==--
