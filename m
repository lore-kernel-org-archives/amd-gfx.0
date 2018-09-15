From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: Re: [BUG] gpu: drm: amdgpu: Possible sleep-in-atomic-context bugs in
 amdgpu_uvd_ring_begin_use()
Date: Sat, 15 Sep 2018 17:33:01 +0800
Message-ID: <9a5f489c-77d3-41b8-401f-9a53fbc265ac@gmail.com>
References: <dbf146f7-1196-43f8-a064-c59638788a54@email.android.com>
 <9dd9f4ed-f338-8970-b29e-200ef0eafb62@gmail.com>
 <68eb2303-ec42-470e-a060-487a14e2708c@email.android.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0763685511=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <68eb2303-ec42-470e-a060-487a14e2708c@email.android.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "airlied@linux.ie" <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

This is a multi-part message in MIME format.
--===============0763685511==
Content-Type: multipart/alternative;
 boundary="------------8815F74234E84A293C73FA9C"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8815F74234E84A293C73FA9C
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit



On 2018/9/15 17:23, Koenig, Christian wrote:
> No, the problem is the function pointer analysis.
>
> In other words the KIQ ring is sometimes used in atomic and even 
> interrupt context.
>
> But the UVD ring is never used in atomic context.
>
> But I don't see a way a static analysis could ever figure that out.
>

Okay, thanks for your explanation :)
Besides, I find that amdgpu_virt_kiq_rreg() calls msleep(), so mdelay() 
should be used instead.


Best wishes,
Jia-Ju Bai

>
> Am 15.09.2018 11:18 schrieb Jia-Ju Bai <baijiaju1990@gmail.com>:
> Sorry, I am still not clear why the call chain I proposed is incorrect...
>
> I find a conditional in amdgpu_mm_wreg():
>
>     if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
>         return amdgpu_virt_kiq_wreg(adev, reg, v);
>
> Is amdgpu_virt_kiq_wreg() never called from WREG32() or RREG32()?
>
>
> Best wishes,
> Jia-Ju Bai
>
>
> On 2018/9/15 17:10, Koenig, Christian wrote:
>> amdgpu_ring_alloc() does call amdgpu_uvd_begin_use(), but never in 
>> the call chain you proposed.
>>
>> Thinking about it I actually don't see a way a statically analysis 
>> could ever figure that out.
>>
>> Christian.
>>
>> Am 15.09.2018 11:05 schrieb Jia-Ju Bai <baijiaju1990@gmail.com>:
>>
>>     Thanks for your reply.
>>
>>     On 2018/9/15 17:01, Koenig, Christian wrote:
>>
>>         Sorry to say that but your analysis tool is buggy.
>>
>>         The proposed call paths will never trigger.
>>
>>
>>     Could you please explain which piece of the call path is incorrect?
>>     I am not very sure of my function pointer analysis.
>>     Does amdgpu_ring_alloc() never calls amdgpu_uvd_ring_begin_use()?
>>
>>     Thanks in advance.
>>
>>
>>     Best wishes,
>>     Jia-Ju Bai
>>
>>
>>         Regards,
>>         Christian.
>>
>>         Am 15.09.2018 10:59 schrieb Jia-Ju Bai
>>         <baijiaju1990@gmail.com> <mailto:baijiaju1990@gmail.com>:
>>         The driver may sleep with holding a spinlock.
>>         The function call paths (from bottom to top) in Linux-4.17 are:
>>
>>         [FUNC] mutex_lock_nested
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
>>              mutex_lock_nested in amdgpu_dpm_enable_uvd
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
>>              amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
>>              [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
>>              amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
>>              amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
>>         drivers/gpu/drm/amd/amdgpu/vi.c, 207:
>>              amdgpu_mm_wreg in vi_gc_cac_rreg
>>         drivers/gpu/drm/amd/amdgpu/vi.c, 206:
>>              _raw_spin_lock_irqsave in vi_gc_cac_rreg
>>
>>         [FUNC] mutex_lock_nested
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
>>              mutex_lock_nested in amdgpu_dpm_enable_uvd
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
>>              amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
>>              [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
>>              amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
>>              amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
>>         drivers/gpu/drm/amd/amdgpu/soc15.c, 106:
>>              amdgpu_mm_wreg in soc15_pcie_rreg
>>         drivers/gpu/drm/amd/amdgpu/soc15.c, 105:
>>              _raw_spin_lock_irqsave in soc15_pcie_rreg
>>
>>         [FUNC] mutex_lock_nested
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
>>              mutex_lock_nested in amdgpu_dpm_enable_uvd
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
>>              amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
>>              [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
>>              amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
>>              amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
>>         drivers/gpu/drm/amd/amdgpu/cik.c, 139:
>>              amdgpu_mm_wreg in cik_uvd_ctx_wreg
>>         drivers/gpu/drm/amd/amdgpu/cik.c, 138:
>>              _raw_spin_lock_irqsave in cik_uvd_ctx_wreg
>>
>>         [FUNC] mutex_lock_nested
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c, 1477:
>>              mutex_lock_nested in amdgpu_dpm_enable_uvd
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c, 1154:
>>              amdgpu_dpm_enable_uvd in amdgpu_uvd_ring_begin_use
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c, 80:
>>              [FUNC_PTR]amdgpu_uvd_ring_begin_use in amdgpu_ring_alloc
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c, 199:
>>              amdgpu_ring_alloc in amdgpu_virt_kiq_wreg
>>         drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:
>>              amdgpu_virt_kiq_wreg in amdgpu_mm_wreg
>>         drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 126:
>>              amdgpu_mm_wreg in dce_v6_0_audio_endpt_rreg
>>         drivers/gpu/drm/amd/amdgpu/dce_v6_0.c, 125:
>>              _raw_spin_lock_irqsave in dce_v6_0_audio_endpt_rreg
>>
>>         Note that [FUNC_PTR] means a function pointer call is used.
>>
>>         These bugs are found by my static analysis tool DSAC.
>>
>>
>>         Best wishes,
>>         Jia-Ju Bai
>>
>>
>>
>


--------------8815F74234E84A293C73FA9C
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p><br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 2018/9/15 17:23, Koenig, Christian
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:68eb2303-ec42-470e-a060-487a14e2708c@email.android.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta content="text/html; charset=utf-8">
      <div dir="auto">No, the problem is the function pointer analysis.
        <div dir="auto"><br>
        </div>
        <div dir="auto">In other words the KIQ ring is sometimes used in
          atomic and even interrupt context.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">But the UVD ring is never used in atomic
          context.</div>
        <div dir="auto"><br>
        </div>
        <div dir="auto">But I don't see a way a static analysis could
          ever figure that out.</div>
        <div dir="auto"><br>
        </div>
      </div>
    </blockquote>
    <br>
    Okay, thanks for your explanation :)<br>
    Besides, I find that amdgpu_virt_kiq_rreg() calls msleep(), so
    mdelay() should be used instead.<br>
    <br>
    <br>
    Best wishes,<br>
    Jia-Ju Bai<br>
    <br>
    <blockquote type="cite"
      cite="mid:68eb2303-ec42-470e-a060-487a14e2708c@email.android.com">
      <div dir="auto"></div>
      <div class="gmail_extra"><br>
        <div class="gmail_quote">Am 15.09.2018 11:18 schrieb Jia-Ju Bai
          <a class="moz-txt-link-rfc2396E" href="mailto:baijiaju1990@gmail.com">&lt;baijiaju1990@gmail.com&gt;</a>:<br type="attribution">
        </div>
      </div>
      <div>Sorry, I am still not clear why the call chain I proposed is
        incorrect...<br>
        <br>
        I find a conditional in amdgpu_mm_wreg():<br>
        <br>
            if (!(acc_flags &amp; AMDGPU_REGS_NO_KIQ) &amp;&amp;
        amdgpu_sriov_runtime(adev))<br>
                return amdgpu_virt_kiq_wreg(adev, reg, v);<br>
        <br>
        Is amdgpu_virt_kiq_wreg() never called from WREG32() or
        RREG32()?<br>
        <br>
        <br>
        Best wishes,<br>
        Jia-Ju Bai<br>
        <br>
        <br>
        <div class="moz-cite-prefix">On 2018/9/15 17:10, Koenig,
          Christian wrote:<br>
        </div>
        <blockquote type="cite">
          <div dir="auto">
            <div>amdgpu_ring_alloc() does call amdgpu_uvd_begin_use(),
              but never in the call chain you proposed.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Thinking about it I actually don't see a way
              a statically analysis could ever figure that out.</div>
            <div dir="auto"><br>
            </div>
            <div dir="auto">Christian.</div>
            <div dir="auto">
              <div class="gmail_extra" dir="auto"><br>
                <div class="gmail_quote">Am 15.09.2018 11:05 schrieb
                  Jia-Ju Bai <a class="moz-txt-link-rfc2396E"
                    href="mailto:baijiaju1990@gmail.com"
                    moz-do-not-send="true">
                    &lt;baijiaju1990@gmail.com&gt;</a>:<br
                    type="attribution">
                  <blockquote class="quote" style="margin:0 0 0 .8ex;
                    border-left:1px #ccc solid; padding-left:1ex">
                    <div>Thanks for your reply.<br>
                      <br>
                      <div>On 2018/9/15 17:01, Koenig, Christian wrote:<br>
                      </div>
                      <blockquote>
                        <div>
                          <div dir="auto">Sorry to say that but your
                            analysis tool is buggy.
                            <div dir="auto"><br>
                            </div>
                            <div dir="auto">The proposed call paths will
                              never trigger.</div>
                          </div>
                        </div>
                      </blockquote>
                      <br>
                      Could you please explain which piece of the call
                      path is incorrect?<br>
                      I am not very sure of my function pointer
                      analysis.<br>
                      Does amdgpu_ring_alloc() never calls
                      amdgpu_uvd_ring_begin_use()?<br>
                      <br>
                      Thanks in advance.<br>
                      <br>
                      <br>
                      Best wishes,<br>
                      Jia-Ju Bai<br>
                      <br>
                      <blockquote>
                        <div>
                          <div dir="auto">
                            <div dir="auto"><br>
                            </div>
                            <div dir="auto">Regards,</div>
                            <div dir="auto">Christian.</div>
                          </div>
                          <div><br>
                            <div>Am 15.09.2018 10:59 schrieb Jia-Ju Bai
                              <a href="mailto:baijiaju1990@gmail.com"
                                moz-do-not-send="true">
                                &lt;baijiaju1990@gmail.com&gt;</a>:<br
                                type="attribution">
                            </div>
                          </div>
                        </div>
                        <font size="2"><span style="font-size:11pt">
                            <div>The driver may sleep with holding a
                              spinlock.<br>
                              The function call paths (from bottom to
                              top) in Linux-4.17 are:<br>
                              <br>
                              [FUNC] mutex_lock_nested<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c,
                              1477:<br>
                                   mutex_lock_nested in
                              amdgpu_dpm_enable_uvd<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c,
                              1154:<br>
                                   amdgpu_dpm_enable_uvd in
                              amdgpu_uvd_ring_begin_use<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c,
                              80:<br>
                                   [FUNC_PTR]amdgpu_uvd_ring_begin_use
                              in amdgpu_ring_alloc<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c,
                              199:<br>
                                   amdgpu_ring_alloc in
                              amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
                                   amdgpu_virt_kiq_wreg in
                              amdgpu_mm_wreg<br>
                              drivers/gpu/drm/amd/amdgpu/vi.c, 207:<br>
                                   amdgpu_mm_wreg in vi_gc_cac_rreg<br>
                              drivers/gpu/drm/amd/amdgpu/vi.c, 206:<br>
                                   _raw_spin_lock_irqsave in
                              vi_gc_cac_rreg<br>
                              <br>
                              [FUNC] mutex_lock_nested<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c,
                              1477:<br>
                                   mutex_lock_nested in
                              amdgpu_dpm_enable_uvd<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c,
                              1154:<br>
                                   amdgpu_dpm_enable_uvd in
                              amdgpu_uvd_ring_begin_use<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c,
                              80:<br>
                                   [FUNC_PTR]amdgpu_uvd_ring_begin_use
                              in amdgpu_ring_alloc<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c,
                              199:<br>
                                   amdgpu_ring_alloc in
                              amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
                                   amdgpu_virt_kiq_wreg in
                              amdgpu_mm_wreg<br>
                              drivers/gpu/drm/amd/amdgpu/soc15.c, 106:<br>
                                   amdgpu_mm_wreg in soc15_pcie_rreg<br>
                              drivers/gpu/drm/amd/amdgpu/soc15.c, 105:<br>
                                   _raw_spin_lock_irqsave in
                              soc15_pcie_rreg<br>
                              <br>
                              [FUNC] mutex_lock_nested<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c,
                              1477:<br>
                                   mutex_lock_nested in
                              amdgpu_dpm_enable_uvd<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c,
                              1154:<br>
                                   amdgpu_dpm_enable_uvd in
                              amdgpu_uvd_ring_begin_use<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c,
                              80:<br>
                                   [FUNC_PTR]amdgpu_uvd_ring_begin_use
                              in amdgpu_ring_alloc<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c,
                              199:<br>
                                   amdgpu_ring_alloc in
                              amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
                                   amdgpu_virt_kiq_wreg in
                              amdgpu_mm_wreg<br>
                              drivers/gpu/drm/amd/amdgpu/cik.c, 139:<br>
                                   amdgpu_mm_wreg in cik_uvd_ctx_wreg<br>
                              drivers/gpu/drm/amd/amdgpu/cik.c, 138:<br>
                                   _raw_spin_lock_irqsave in
                              cik_uvd_ctx_wreg<br>
                              <br>
                              [FUNC] mutex_lock_nested<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c,
                              1477:<br>
                                   mutex_lock_nested in
                              amdgpu_dpm_enable_uvd<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c,
                              1154:<br>
                                   amdgpu_dpm_enable_uvd in
                              amdgpu_uvd_ring_begin_use<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c,
                              80:<br>
                                   [FUNC_PTR]amdgpu_uvd_ring_begin_use
                              in amdgpu_ring_alloc<br>
                              drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c,
                              199:<br>
                                   amdgpu_ring_alloc in
                              amdgpu_virt_kiq_wreg<br>
drivers/gpu/drm/amd/amdgpu/amdgpu_device.c, 207:<br>
                                   amdgpu_virt_kiq_wreg in
                              amdgpu_mm_wreg<br>
                              drivers/gpu/drm/amd/amdgpu/dce_v6_0.c,
                              126:<br>
                                   amdgpu_mm_wreg in
                              dce_v6_0_audio_endpt_rreg<br>
                              drivers/gpu/drm/amd/amdgpu/dce_v6_0.c,
                              125:<br>
                                   _raw_spin_lock_irqsave in
                              dce_v6_0_audio_endpt_rreg<br>
                              <br>
                              Note that [FUNC_PTR] means a function
                              pointer call is used.<br>
                              <br>
                              These bugs are found by my static analysis
                              tool DSAC.<br>
                              <br>
                              <br>
                              Best wishes,<br>
                              Jia-Ju Bai<br>
                            </div>
                          </span></font></blockquote>
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
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8815F74234E84A293C73FA9C--

--===============0763685511==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0763685511==--
