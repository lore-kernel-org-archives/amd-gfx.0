From: James Zhu <jamesz-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu:No action needs when VCN PG state is unchanged
Date: Tue, 11 Sep 2018 12:20:41 -0400
Message-ID: <b81f68bb-0ac3-9b8f-752d-ec0962e030a7@amd.com>
References: <82dc897f-8405-41b2-9482-43d567ec4fcc@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0029730585=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <82dc897f-8405-41b2-9482-43d567ec4fcc-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0029730585==
Content-Type: multipart/alternative;
 boundary="------------56743E4816CE7E0690001730"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------56743E4816CE7E0690001730
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Christian,

Thanks!

I add this check for VCN DPG/DPG PAUSE mode implementation.

Do you think it is necessary to add for other IP blocks if they need or 
just for VCN only?

Best Regards!

James Zhu


On 2018-09-11 12:14 PM, Koenig, Christian wrote:
> Hi James,
>
> Am 11.09.2018 17:44 schrieb "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>:
>
>
>
>     On 2018-09-11 11:36 AM, Christian König wrote:
>
>         Am 11.09.2018 um 17:29 schrieb James Zhu:
>
>
>
>             On 2018-09-11 11:17 AM, Christian König wrote:
>
>                 Am 11.09.2018 um 17:06 schrieb James Zhu:
>
>
>
>                     On 2018-09-11 10:44 AM, Alex Deucher wrote:
>
>                         On Mon, Sep 10, 2018 at 4:34 PM James Zhu<jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>  wrote:
>
>                             Signed-off-by: James Zhu<James.Zhu-5C7GfCeVMHo@public.gmane.org> <mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org>
>
>                             When VCN PG state is unchanged, it is unnecessary to reset
>                             power gate state again.
>
>                         Don't you need to initialize and store the PG state somewhere?  You
>                         are just using a local variable here.
>
>                         Alex
>
>                     Hi Alex,
>
>                     I used */static/* for this local state
>                     variable(*cur_state*) with initialization state
>                     AMD_PG_STATE_GATE.
>
>
>                 That won't work correctly. A "static" variable is
>                 global, but the power state is per device.
>
>                 Regards,
>                 Christian.
>
>             This "static" variable under local scope is mainly for VCN
>             used only. It only tracks VCN's PG state.
>             (currently VCN only have one hardware instance)
>
>
>         Still an absolute no-go for kernel coding. VCN will soon be
>         used for dGPUs as well.
>
>         Please fix and reiterate,
>         Christian.
>
>     I see, then I will put this current state track into struct
>     amdgpu_vcn.
>
>     By the way, under multiple dPGU situation, I though per dPGU will
>     create it's own driver instance.
>     this static variable won't be shared cross driver instance. Am I
>     right?
>
>
> No that is not correct.
>
> Static variables both on function as well as module level are shared 
> between all amdgpu devices.
>
> Regards,
> Christian.
>
>
>     Thanks!
>     James Zhu
>
>
>             Best Regards!
>             James Zhu
>
>                     this variable's scope is only inside this
>                     function, but it's initialization is done
>                     once at compile time and it's lifetime will last
>                     until the driver exit.
>
>                     Since it is only used inside this function, I
>                     didn't put it into struct amdgpu_vcn.
>
>                     Best Regards!
>                     James Zhu
>
>                             ---
>                               drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++++--
>                               1 file changed, 11 insertions(+), 2 deletions(-)
>
>                             diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>                             index 2664bb2..86d98d2 100644
>                             --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>                             +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
>                             @@ -1633,12 +1633,21 @@ static int vcn_v1_0_set_powergating_state(void *handle,
>                                       * revisit this when there is a cleaner line between
>                                       * the smc and the hw blocks
>                                       */
>                             +       int ret;
>                             +       static enum amd_powergating_state cur_state = AMD_PG_STATE_GATE;
>                                      struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>
>                             +       if (state == cur_state)
>                             +               return 0;
>                             +
>                                      if (state == AMD_PG_STATE_GATE)
>                             -               return vcn_v1_0_stop(adev);
>                             +               ret = vcn_v1_0_stop(adev);
>                                      else
>                             -               return vcn_v1_0_start(adev);
>                             +               ret = vcn_v1_0_start(adev);
>                             +
>                             +       if (!ret)
>                             +               cur_state = state;
>                             +       return ret;
>                               }
>
>                               static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
>                             --
>                             2.7.4
>
>                             _______________________________________________
>                             amd-gfx mailing list
>                             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>                             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>                     _______________________________________________
>                     amd-gfx mailing list
>                     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>                     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>                     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>
>
>             _______________________________________________
>             amd-gfx mailing list
>             amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>             https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
>


--------------56743E4816CE7E0690001730
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Hi Christian,</p>
    <p>Thanks!</p>
    <p>I add this check for VCN DPG/DPG PAUSE mode implementation.</p>
    <p>Do you think it is necessary to add for other IP blocks if they
      need or just for VCN only?</p>
    <p>Best Regards!</p>
    <p>James Zhu<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018-09-11 12:14 PM, Koenig,
      Christian wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:82dc897f-8405-41b2-9482-43d567ec4fcc-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <div dir="auto">
        <div>Hi James,<br>
          <div class="gmail_extra"><br>
            <div class="gmail_quote">Am 11.09.2018 17:44 schrieb "Zhu,
              James" <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>:<br type="attribution">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div>
                  <p><br>
                  </p>
                  <br>
                  <div>On 2018-09-11 11:36 AM, Christian König wrote:<br>
                  </div>
                  <blockquote>
                    <div>Am 11.09.2018 um 17:29 schrieb James Zhu:<br>
                    </div>
                    <blockquote>
                      <p><br>
                      </p>
                      <br>
                      <div>On 2018-09-11 11:17 AM, Christian König
                        wrote:<br>
                      </div>
                      <blockquote>
                        <div>Am 11.09.2018 um 17:06 schrieb James Zhu:<br>
                        </div>
                        <blockquote>
                          <p><br>
                          </p>
                          <br>
                          <div>On 2018-09-11 10:44 AM, Alex Deucher
                            wrote:<br>
                          </div>
                          <blockquote>
                            <pre>On Mon, Sep 10, 2018 at 4:34 PM James Zhu <a href="mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" moz-do-not-send="true">&lt;jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a> wrote:
</pre>
                            <blockquote>
                              <pre>Signed-off-by: James Zhu <a href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org" moz-do-not-send="true">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a>

When VCN PG state is unchanged, it is unnecessary to reset
power gate state again.
</pre>
                            </blockquote>
                            <pre>Don't you need to initialize and store the PG state somewhere?  You
are just using a local variable here.

Alex

</pre>
                          </blockquote>
                          Hi Alex,<br>
                          <br>
                          I used <b><i>static</i></b> for this local
                          state variable(<b>cur_state</b>) with
                          initialization state AMD_PG_STATE_GATE.<br>
                        </blockquote>
                        <br>
                        That won't work correctly. A "static" variable
                        is global, but the power state is per device.<br>
                        <br>
                        Regards,<br>
                        Christian.<br>
                        <br>
                      </blockquote>
                      This "static" variable under local scope is mainly
                      for VCN used only. It only tracks VCN's PG state.<br>
                      (currently VCN only have one hardware instance)<br>
                    </blockquote>
                    <br>
                    Still an absolute no-go for kernel coding. VCN will
                    soon be used for dGPUs as well.<br>
                    <br>
                    Please fix and reiterate,<br>
                    Christian.<br>
                  </blockquote>
                  I see, then I will put this current state track into
                  struct amdgpu_vcn.<br>
                  <br>
                  By the way, under multiple dPGU situation, I though
                  per dPGU will create it's own driver instance.<br>
                  this static variable won't be shared cross driver
                  instance. Am I right?<br>
                </div>
              </blockquote>
            </div>
          </div>
        </div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">No that is not correct.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Static variables both on function as well as
          module level are shared between all amdgpu devices.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">Regards,</div>
        <div dir="auto">Christian.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">
          <div class="gmail_extra">
            <div class="gmail_quote">
              <blockquote class="quote" style="margin:0 0 0
                .8ex;border-left:1px #ccc solid;padding-left:1ex">
                <div><br>
                  Thanks!<br>
                  James Zhu<br>
                  <blockquote>
                    <blockquote><br>
                      Best Regards!<br>
                      James Zhu<br>
                      <blockquote>
                        <blockquote>this variable's scope is only inside
                          this function, but it's initialization is done
                          <br>
                          once at compile time and it's lifetime will
                          last until the driver exit.<br>
                          <br>
                          Since it is only used inside this function, I
                          didn't put it into struct amdgpu_vcn.<br>
                          <br>
                          Best Regards!<br>
                          James Zhu<br>
                          <blockquote>
                            <blockquote>
                              <pre>---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 2664bb2..86d98d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1633,12 +1633,21 @@ static int vcn_v1_0_set_powergating_state(void *handle,
         * revisit this when there is a cleaner line between
         * the smc and the hw blocks
         */
+       int ret;
+       static enum amd_powergating_state cur_state = AMD_PG_STATE_GATE;
        struct amdgpu_device *adev = (struct amdgpu_device *)handle;

+       if (state == cur_state)
+               return 0;
+
        if (state == AMD_PG_STATE_GATE)
-               return vcn_v1_0_stop(adev);
+               ret = vcn_v1_0_stop(adev);
        else
-               return vcn_v1_0_start(adev);
+               ret = vcn_v1_0_start(adev);
+
+       if (!ret)
+               cur_state = state;
+       return ret;
 }

 static const struct amd_ip_funcs vcn_v1_0_ip_funcs = {
--
2.7.4

_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                            </blockquote>
                          </blockquote>
                          <br>
                          <br>
                          <fieldset></fieldset>
                          <br>
                          <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                        </blockquote>
                        <br>
                      </blockquote>
                      <br>
                      <br>
                      <fieldset></fieldset>
                      <br>
                      <pre>_______________________________________________
amd-gfx mailing list
<a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
                    </blockquote>
                    <br>
                  </blockquote>
                  <br>
                </div>
              </blockquote>
            </div>
            <br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------56743E4816CE7E0690001730--

--===============0029730585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0029730585==--
