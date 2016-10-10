From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read
Date: Mon, 10 Oct 2016 15:49:21 +0200
Message-ID: <3c1d969b-0141-ef29-1e0f-5267d8a7cae9@vodafone.de>
References: <20161010125128.18303-1-tom.stdenis@amd.com>
 <91da2060-e6d4-70c9-2ceb-69218e1058ba@vodafone.de>
 <CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0687536458=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0687536458==
Content-Type: multipart/alternative;
 boundary="------------90A22BAAD31472B2FDC04514"

This is a multi-part message in MIME format.
--------------90A22BAAD31472B2FDC04514
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Would it hurt us to always take the looks (both the pm as well as grbm 
idx lock)?

I don't think that would be much of an issue and I would have a better 
feeling with that.

Christian.

Am 10.10.2016 um 15:38 schrieb Tom St Denis:
>
> that's kind of the point.  Its for debugging only. Also reads can 
> already lock
>
>
> On Mon, Oct 10, 2016, 09:25 Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org 
> <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>
>     Mhm, that userspace controls if the lock is taken or not is a bit
>     problematic, on the other hand only root could access that.
>
>     Christian.
>
>     Am 10.10.2016 um 14:51 schrieb Tom St Denis:
>     > Add PG lock support as well as bank selection to
>     > the MMIO write function.
>     >
>     > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org
>     <mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org>>
>     > ---
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43
>     ++++++++++++++++++++++++++++++
>     >   1 file changed, 43 insertions(+)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > index 04c4aee70452..a9d83c1d7a43 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>     > @@ -2637,10 +2637,45 @@ static ssize_t
>     amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>     >       struct amdgpu_device *adev = f->f_inode->i_private;
>     >       ssize_t result = 0;
>     >       int r;
>     > +     bool pm_pg_lock, use_bank;
>     > +     unsigned instance_bank, sh_bank, se_bank;
>     >
>     >       if (size & 0x3 || *pos & 0x3)
>     >               return -EINVAL;
>     >
>     > +     /* are we reading registers for which a PG lock is
>     necessary? */
>     > +     pm_pg_lock = (*pos >> 23) & 1;
>     > +
>     > +     if (*pos & (1ULL << 62)) {
>     > +             se_bank = (*pos >> 24) & 0x3FF;
>     > +             sh_bank = (*pos >> 34) & 0x3FF;
>     > +             instance_bank = (*pos >> 44) & 0x3FF;
>     > +
>     > +             if (se_bank == 0x3FF)
>     > +                     se_bank = 0xFFFFFFFF;
>     > +             if (sh_bank == 0x3FF)
>     > +                     sh_bank = 0xFFFFFFFF;
>     > +             if (instance_bank == 0x3FF)
>     > +                     instance_bank = 0xFFFFFFFF;
>     > +             use_bank = 1;
>     > +     } else {
>     > +             use_bank = 0;
>     > +     }
>     > +
>     > +     *pos &= 0x3FFFF;
>     > +
>     > +     if (use_bank) {
>     > +             if ((sh_bank != 0xFFFFFFFF && sh_bank >=
>     adev->gfx.config.max_sh_per_se) ||
>     > +                 (se_bank != 0xFFFFFFFF && se_bank >=
>     adev->gfx.config.max_shader_engines))
>     > +                     return -EINVAL;
>     > +             mutex_lock(&adev->grbm_idx_mutex);
>     > +             amdgpu_gfx_select_se_sh(adev, se_bank,
>     > +                                     sh_bank, instance_bank);
>     > +     }
>     > +
>     > +     if (pm_pg_lock)
>     > +             mutex_lock(&adev->pm.mutex);
>     > +
>     >       while (size) {
>     >               uint32_t value;
>     >
>     > @@ -2659,6 +2694,14 @@ static ssize_t
>     amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>     >               size -= 4;
>     >       }
>     >
>     > +     if (use_bank) {
>     > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>     0xffffffff, 0xffffffff);
>     > +             mutex_unlock(&adev->grbm_idx_mutex);
>     > +     }
>     > +
>     > +     if (pm_pg_lock)
>     > +             mutex_unlock(&adev->pm.mutex);
>     > +
>     >       return result;
>     >   }
>     >
>
>


--------------90A22BAAD31472B2FDC04514
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Would it hurt us to always take the
      looks (both the pm as well as grbm idx lock)?<br>
      <br>
      I don't think that would be much of an issue and I would have a
      better feeling with that.<br>
      <br>
      Christian.<br>
      <br>
      Am 10.10.2016 um 15:38 schrieb Tom St Denis:<br>
    </div>
    <blockquote
cite="mid:CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
      type="cite">
      <p dir="ltr">that's kind of the point.  Its for debugging only. 
        Also reads can already lock</p>
      <br>
      <div class="gmail_quote">
        <div dir="ltr">On Mon, Oct 10, 2016, 09:25 Christian König &lt;<a
            moz-do-not-send="true" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Mhm, that
          userspace controls if the lock is taken or not is a bit<br
            class="gmail_msg">
          problematic, on the other hand only root could access that.<br
            class="gmail_msg">
          <br class="gmail_msg">
          Christian.<br class="gmail_msg">
          <br class="gmail_msg">
          Am 10.10.2016 um 14:51 schrieb Tom St Denis:<br
            class="gmail_msg">
          &gt; Add PG lock support as well as bank selection to<br
            class="gmail_msg">
          &gt; the MMIO write function.<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; Signed-off-by: Tom St Denis &lt;<a moz-do-not-send="true"
            href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" class="gmail_msg"
            target="_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br
            class="gmail_msg">
          &gt; ---<br class="gmail_msg">
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43
          ++++++++++++++++++++++++++++++<br class="gmail_msg">
          &gt;   1 file changed, 43 insertions(+)<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
            class="gmail_msg">
          &gt; index 04c4aee70452..a9d83c1d7a43 100644<br
            class="gmail_msg">
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
            class="gmail_msg">
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
            class="gmail_msg">
          &gt; @@ -2637,10 +2637,45 @@ static ssize_t
          amdgpu_debugfs_regs_write(struct file *f, const char __user
          *buf,<br class="gmail_msg">
          &gt;       struct amdgpu_device *adev =
          f-&gt;f_inode-&gt;i_private;<br class="gmail_msg">
          &gt;       ssize_t result = 0;<br class="gmail_msg">
          &gt;       int r;<br class="gmail_msg">
          &gt; +     bool pm_pg_lock, use_bank;<br class="gmail_msg">
          &gt; +     unsigned instance_bank, sh_bank, se_bank;<br
            class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt;       if (size &amp; 0x3 || *pos &amp; 0x3)<br
            class="gmail_msg">
          &gt;               return -EINVAL;<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; +     /* are we reading registers for which a PG lock is
          necessary? */<br class="gmail_msg">
          &gt; +     pm_pg_lock = (*pos &gt;&gt; 23) &amp; 1;<br
            class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +     if (*pos &amp; (1ULL &lt;&lt; 62)) {<br
            class="gmail_msg">
          &gt; +             se_bank = (*pos &gt;&gt; 24) &amp; 0x3FF;<br
            class="gmail_msg">
          &gt; +             sh_bank = (*pos &gt;&gt; 34) &amp; 0x3FF;<br
            class="gmail_msg">
          &gt; +             instance_bank = (*pos &gt;&gt; 44) &amp;
          0x3FF;<br class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +             if (se_bank == 0x3FF)<br class="gmail_msg">
          &gt; +                     se_bank = 0xFFFFFFFF;<br
            class="gmail_msg">
          &gt; +             if (sh_bank == 0x3FF)<br class="gmail_msg">
          &gt; +                     sh_bank = 0xFFFFFFFF;<br
            class="gmail_msg">
          &gt; +             if (instance_bank == 0x3FF)<br
            class="gmail_msg">
          &gt; +                     instance_bank = 0xFFFFFFFF;<br
            class="gmail_msg">
          &gt; +             use_bank = 1;<br class="gmail_msg">
          &gt; +     } else {<br class="gmail_msg">
          &gt; +             use_bank = 0;<br class="gmail_msg">
          &gt; +     }<br class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +     *pos &amp;= 0x3FFFF;<br class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +     if (use_bank) {<br class="gmail_msg">
          &gt; +             if ((sh_bank != 0xFFFFFFFF &amp;&amp;
          sh_bank &gt;= adev-&gt;gfx.config.max_sh_per_se) ||<br
            class="gmail_msg">
          &gt; +                 (se_bank != 0xFFFFFFFF &amp;&amp;
          se_bank &gt;= adev-&gt;gfx.config.max_shader_engines))<br
            class="gmail_msg">
          &gt; +                     return -EINVAL;<br
            class="gmail_msg">
          &gt; +             mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br
            class="gmail_msg">
          &gt; +             amdgpu_gfx_select_se_sh(adev, se_bank,<br
            class="gmail_msg">
          &gt; +                                     sh_bank,
          instance_bank);<br class="gmail_msg">
          &gt; +     }<br class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +     if (pm_pg_lock)<br class="gmail_msg">
          &gt; +             mutex_lock(&amp;adev-&gt;pm.mutex);<br
            class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt;       while (size) {<br class="gmail_msg">
          &gt;               uint32_t value;<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; @@ -2659,6 +2694,14 @@ static ssize_t
          amdgpu_debugfs_regs_write(struct file *f, const char __user
          *buf,<br class="gmail_msg">
          &gt;               size -= 4;<br class="gmail_msg">
          &gt;       }<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          &gt; +     if (use_bank) {<br class="gmail_msg">
          &gt; +             amdgpu_gfx_select_se_sh(adev, 0xffffffff,
          0xffffffff, 0xffffffff);<br class="gmail_msg">
          &gt; +             mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br
            class="gmail_msg">
          &gt; +     }<br class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt; +     if (pm_pg_lock)<br class="gmail_msg">
          &gt; +             mutex_unlock(&amp;adev-&gt;pm.mutex);<br
            class="gmail_msg">
          &gt; +<br class="gmail_msg">
          &gt;       return result;<br class="gmail_msg">
          &gt;   }<br class="gmail_msg">
          &gt;<br class="gmail_msg">
          <br class="gmail_msg">
          <br class="gmail_msg">
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------90A22BAAD31472B2FDC04514--

--===============0687536458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0687536458==--
