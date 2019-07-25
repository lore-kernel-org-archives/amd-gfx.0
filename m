From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu/vcn_v2_0: Set CMD_SOURCE for RB commands
Date: Thu, 25 Jul 2019 10:09:30 +0200
Message-ID: <1117bfaf-9158-30f8-9ce1-47f87582ec06@gmail.com>
References: <BN6PR1201MB0178175C942E341FCEB0D07B9DC60@BN6PR1201MB0178.namprd12.prod.outlook.com>
 <DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60@DM5PR12MB2456.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0525257288=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60-2J9CzHegvk8TFHufQck+3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Liu, Leo" <Leo.Liu-5C7GfCeVMHo@public.gmane.org>, "Thai, Thong" <Thong.Thai-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0525257288==
Content-Type: multipart/alternative;
 boundary="------------503B35CF84205E96698ED970"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------503B35CF84205E96698ED970
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Should we have a define for the 0x80000000 somewhere?

And please break the commit log into fewer characters per line.

Apart from that looks good to me,
Christian.

Am 25.07.19 um 00:23 schrieb Liu, Leo:
> Please separate the patches to 2 patches. i. e. New ring test as one 
> patch.
>
> Regards,
> Leo
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Thai, Thong <Thong.Thai-5C7GfCeVMHo@public.gmane.org>
> *Sent:* July 24, 2019 3:50:47 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* [PATCH] drm/amd/amdgpu/vcn_v2_0: Set CMD_SOURCE for RB 
> commands
> Sets the CMD_SOURCE bit for VCN 2.0 decoder ring-buffer commands. This 
> bit was previously set by the RBC HW on older versions of the 
> firmware, and now needs to be set by the driver in order to work with 
> the SW RBC found in newer versions of the firmware.
>
> Signed-off-by: Thong Thai <thong.thai-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 44 ++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c 
> b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index bc9726787c97..8daee23425f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1488,7 +1488,7 @@ static void 
> vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));
>          amdgpu_ring_write(ring, 0);
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_START << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_START 
> << 1));
>  }
>
>  /**
> @@ -1501,7 +1501,7 @@ static void 
> vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)
>  static void vcn_v2_0_dec_ring_insert_end(struct amdgpu_ring *ring)
>  {
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_END << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_END 
> << 1));
>  }
>
>  /**
> @@ -1546,7 +1546,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct 
> amdgpu_ring *ring, u64 addr, u64
>          amdgpu_ring_write(ring, upper_32_bits(addr) & 0xff);
>
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_FENCE << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_FENCE << 1));
>
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));
>          amdgpu_ring_write(ring, 0);
> @@ -1556,7 +1556,7 @@ static void vcn_v2_0_dec_ring_emit_fence(struct 
> amdgpu_ring *ring, u64 addr, u64
>
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
>
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_TRAP << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_TRAP << 1));
>  }
>
>  /**
> @@ -1600,7 +1600,7 @@ static void 
> vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring,
>
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
>
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_REG_READ_COND_WAIT << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | 
> (VCN_DEC_CMD_REG_READ_COND_WAIT << 1));
>  }
>
>  static void vcn_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
> @@ -1629,7 +1629,7 @@ static void vcn_v2_0_dec_ring_emit_wreg(struct 
> amdgpu_ring *ring,
>
>          amdgpu_ring_write(ring, 
> PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));
>
> -       amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_REG << 1);
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_WRITE_REG << 
> 1));
>  }
>
>  /**
> @@ -2082,6 +2082,36 @@ static int vcn_v2_0_process_interrupt(struct 
> amdgpu_device *adev,
>          return 0;
>  }
>
> +int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)
> +{
> +       struct amdgpu_device *adev = ring->adev;
> +       uint32_t tmp = 0;
> +       unsigned i;
> +       int r;
> +
> +       WREG32(adev->vcn.external.scratch9, 0xCAFEDEAD);
> +       r = amdgpu_ring_alloc(ring, 3);
> +       if (r)
> +               return r;
> +       amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.cmd, 0));
> +       amdgpu_ring_write(ring, 0x80000000 | (VCN_DEC_CMD_PACKET_START 
> << 1));
> +       amdgpu_ring_write(ring, PACKET0(adev->vcn.internal.scratch9, 0));
> +       amdgpu_ring_write(ring, 0xDEADBEEF);
> +       amdgpu_ring_commit(ring);
> +       for (i = 0; i < adev->usec_timeout; i++) {
> +               tmp = RREG32(adev->vcn.external.scratch9);
> +               if (tmp == 0xDEADBEEF)
> +                       break;
> +               DRM_UDELAY(1);
> +       }
> +
> +       if (i >= adev->usec_timeout)
> +               r = -ETIMEDOUT;
> +
> +       return r;
> +}
> +
> +
>  static int vcn_v2_0_set_powergating_state(void *handle,
>                                            enum amd_powergating_state 
> state)
>  {
> @@ -2145,7 +2175,7 @@ static const struct amdgpu_ring_funcs 
> vcn_v2_0_dec_ring_vm_funcs = {
>          .emit_ib = vcn_v2_0_dec_ring_emit_ib,
>          .emit_fence = vcn_v2_0_dec_ring_emit_fence,
>          .emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,
> -       .test_ring = amdgpu_vcn_dec_ring_test_ring,
> +       .test_ring = vcn_v2_0_dec_ring_test_ring,
>          .test_ib = amdgpu_vcn_dec_ring_test_ib,
>          .insert_nop = vcn_v2_0_dec_ring_insert_nop,
>          .insert_start = vcn_v2_0_dec_ring_insert_start,
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------503B35CF84205E96698ED970
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Should we have a define for the
      0x80000000 somewhere?<br>
      <br>
      And please break the commit log into fewer characters per line.<br>
      <br>
      Apart from that looks good to me,<br>
      Christian.<br>
      <br>
      Am 25.07.19 um 00:23 schrieb Liu, Leo:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB2456E8FF88AA6C6F48A0A12FE5C60-2J9CzHegvk8TFHufQck+3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      Please separate the patches to 2 patches. i. e. New ring test as
      one patch.<br>
      <br>
      Regards, <br>
      Leo<br>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Thai, Thong <a class="moz-txt-link-rfc2396E" href="mailto:Thong.Thai-5C7GfCeVMHo@public.gmane.org">&lt;Thong.Thai-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> July 24, 2019 3:50:47 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Subject:</b> [PATCH] drm/amd/amdgpu/vcn_v2_0: Set
          CMD_SOURCE for RB commands</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Sets the CMD_SOURCE bit for VCN 2.0
              decoder ring-buffer commands. This bit was previously set
              by the RBC HW on older versions of the firmware, and now
              needs to be set by the driver in order to work with the SW
              RBC found in newer versions of the firmware.<br>
              <br>
              Signed-off-by: Thong Thai <a class="moz-txt-link-rfc2396E" href="mailto:thong.thai-5C7GfCeVMHo@public.gmane.org">&lt;thong.thai-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 44
              ++++++++++++++++++++++-----<br>
               1 file changed, 37 insertions(+), 7 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
              b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
              index bc9726787c97..8daee23425f8 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c<br>
              @@ -1488,7 +1488,7 @@ static void
              vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)<br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
                       amdgpu_ring_write(ring, 0);<br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
              -       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_START
              &lt;&lt; 1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_PACKET_START &lt;&lt; 1));<br>
               }<br>
               <br>
               /**<br>
              @@ -1501,7 +1501,7 @@ static void
              vcn_v2_0_dec_ring_insert_start(struct amdgpu_ring *ring)<br>
               static void vcn_v2_0_dec_ring_insert_end(struct
              amdgpu_ring *ring)<br>
               {<br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
              -       amdgpu_ring_write(ring, VCN_DEC_CMD_PACKET_END
              &lt;&lt; 1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_PACKET_END &lt;&lt; 1));<br>
               }<br>
               <br>
               /**<br>
              @@ -1546,7 +1546,7 @@ static void
              vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64
              addr, u64<br>
                       amdgpu_ring_write(ring, upper_32_bits(addr) &amp;
              0xff);<br>
               <br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
              -       amdgpu_ring_write(ring, VCN_DEC_CMD_FENCE &lt;&lt;
              1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_FENCE &lt;&lt; 1));<br>
               <br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_DATA0_INTERNAL_OFFSET, 0));<br>
                       amdgpu_ring_write(ring, 0);<br>
              @@ -1556,7 +1556,7 @@ static void
              vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64
              addr, u64<br>
               <br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
               <br>
              -       amdgpu_ring_write(ring, VCN_DEC_CMD_TRAP &lt;&lt;
              1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_TRAP &lt;&lt; 1));<br>
               }<br>
               <br>
               /**<br>
              @@ -1600,7 +1600,7 @@ static void
              vcn_v2_0_dec_ring_emit_reg_wait(struct amdgpu_ring *ring,<br>
               <br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
               <br>
              -       amdgpu_ring_write(ring,
              VCN_DEC_CMD_REG_READ_COND_WAIT &lt;&lt; 1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_REG_READ_COND_WAIT &lt;&lt; 1));<br>
               }<br>
               <br>
               static void vcn_v2_0_dec_ring_emit_vm_flush(struct
              amdgpu_ring *ring,<br>
              @@ -1629,7 +1629,7 @@ static void
              vcn_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,<br>
               <br>
                       amdgpu_ring_write(ring,
              PACKET0(mmUVD_GPCOM_VCPU_CMD_INTERNAL_OFFSET, 0));<br>
               <br>
              -       amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_REG
              &lt;&lt; 1);<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_WRITE_REG &lt;&lt; 1));<br>
               }<br>
               <br>
               /**<br>
              @@ -2082,6 +2082,36 @@ static int
              vcn_v2_0_process_interrupt(struct amdgpu_device *adev,<br>
                       return 0;<br>
               }<br>
               <br>
              +int vcn_v2_0_dec_ring_test_ring(struct amdgpu_ring *ring)<br>
              +{<br>
              +       struct amdgpu_device *adev = ring-&gt;adev;<br>
              +       uint32_t tmp = 0;<br>
              +       unsigned i;<br>
              +       int r;<br>
              +<br>
              +       WREG32(adev-&gt;vcn.external.scratch9,
              0xCAFEDEAD);<br>
              +       r = amdgpu_ring_alloc(ring, 3);<br>
              +       if (r)<br>
              +               return r;<br>
              +       amdgpu_ring_write(ring,
              PACKET0(adev-&gt;vcn.internal.cmd, 0));<br>
              +       amdgpu_ring_write(ring, 0x80000000 |
              (VCN_DEC_CMD_PACKET_START &lt;&lt; 1));<br>
              +       amdgpu_ring_write(ring,
              PACKET0(adev-&gt;vcn.internal.scratch9, 0));<br>
              +       amdgpu_ring_write(ring, 0xDEADBEEF);<br>
              +       amdgpu_ring_commit(ring);<br>
              +       for (i = 0; i &lt; adev-&gt;usec_timeout; i++) {<br>
              +               tmp =
              RREG32(adev-&gt;vcn.external.scratch9);<br>
              +               if (tmp == 0xDEADBEEF)<br>
              +                       break;<br>
              +               DRM_UDELAY(1);<br>
              +       }<br>
              +<br>
              +       if (i &gt;= adev-&gt;usec_timeout)<br>
              +               r = -ETIMEDOUT;<br>
              +<br>
              +       return r;<br>
              +}<br>
              +<br>
              +<br>
               static int vcn_v2_0_set_powergating_state(void *handle,<br>
                                                         enum
              amd_powergating_state state)<br>
               {<br>
              @@ -2145,7 +2175,7 @@ static const struct
              amdgpu_ring_funcs vcn_v2_0_dec_ring_vm_funcs = {<br>
                       .emit_ib = vcn_v2_0_dec_ring_emit_ib,<br>
                       .emit_fence = vcn_v2_0_dec_ring_emit_fence,<br>
                       .emit_vm_flush = vcn_v2_0_dec_ring_emit_vm_flush,<br>
              -       .test_ring = amdgpu_vcn_dec_ring_test_ring,<br>
              +       .test_ring = vcn_v2_0_dec_ring_test_ring,<br>
                       .test_ib = amdgpu_vcn_dec_ring_test_ib,<br>
                       .insert_nop = vcn_v2_0_dec_ring_insert_nop,<br>
                       .insert_start = vcn_v2_0_dec_ring_insert_start,<br>
              -- <br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------503B35CF84205E96698ED970--

--===============0525257288==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0525257288==--
