From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read
Date: Tue, 11 Oct 2016 14:35:14 +0200
Message-ID: <361f4210-31d4-a517-e80c-254e6d2dea9d@vodafone.de>
References: <20161010125128.18303-1-tom.stdenis@amd.com>
 <91da2060-e6d4-70c9-2ceb-69218e1058ba@vodafone.de>
 <CAAzXoRJKusZrvv7obpZ-0tR39pVmdc-7Y8prKCsRC6bchmsOcA@mail.gmail.com>
 <3c1d969b-0141-ef29-1e0f-5267d8a7cae9@vodafone.de>
 <CY4PR12MB1768813E554E6DB1A40F5848F7DB0@CY4PR12MB1768.namprd12.prod.outlook.com>
 <50dc12b3-a6bd-ed35-ac8f-e55909d184d2@vodafone.de>
 <CY4PR12MB1768134851FB1F505F746843F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0092430761=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768134851FB1F505F746843F7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0092430761==
Content-Type: multipart/alternative;
 boundary="------------2E4B51A2E29BFEB0586C2D2A"

This is a multi-part message in MIME format.
--------------2E4B51A2E29BFEB0586C2D2A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tom,

yeah, the timing issue is a good argument. In this case just go ahead 
and add my Acked-by to the patch.

Regards,
Christian.

Am 11.10.2016 um 14:19 schrieb StDenis, Tom:
>
> Hi Christian,
>
>
> I agree with the crux of your argument but you can crash the system 
> with carefully timed read/writes from the GFX registers, or MC, or ... 
> That's why the entries are root only.
>
>
> The issue with locking excessively is you might change behaviour of 
> something you're trying to debug because the kernel then has to wait 
> on the lock (or you're waiting on the lock).  For instance, suppose 
> you want to read DCE registers and the kernel is doing some gfx/grbm 
> related your DCE read will either block the GFX activity or you're 
> waiting on it which means the behaviour of the system could be 
> different than from the case where you're not probing the registers.
>
>
> The goal is to be as unobtrusive as possible.  Heck I often mmap the 
> BAR so I can read MMIO registers directly and not waste CPU cycles on 
> syscalls.
>
>
> The PM lock is because reading PGFSM registers during a powerup/down 
> results in a GPU hang, and we only take the GRBM lock when users want 
> to read from specific banks.  For any other case we don't need a lock. 
>  In the kernel they should be mutually exclusive.  The PM lock is only 
> taken in PP when performing a transition (or initializing the core) 
> and I have yet to see a place where PP/PM related code also grabs the 
> grbm index lock.
>
> I don't have strong feelings against your proposal but I do prefer not 
> to take the locks when I don't need to.  Ultimately I'll leave the 
> decision up to you and Alex.  I'd like to get the 2nd patch through 
> though as it makes the write side of the mmio reg complimentary (e.g. 
> bank selection/pm lock).
>
> Cheers,
> Tom
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Tuesday, October 11, 2016 08:11
> *To:* StDenis, Tom; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment read
>>
>> The only downside to taking the locks all the time is for 99% of 
>> debug reads it's unnecessary and in theory could lead to 
>> performance/behaviour problems.
>>
> Yeah, but performance isn't critical here and taking two locks 
> compared to the rest of what we (IOCTL etc...) do is completely 
> negligibly.
>
>> I've been using this on read for a while now and haven't noticed a 
>> problem.
>>
> My concern is rather that somebody tries to write to the PM regs on 
> accident or purpose without taking the lock.
>
> See, the kernel is usually responsible to keep people from doing 
> stupid things with the hardware, even if those people are root and 
> could do stupid things anyway. Well, you know what I mean?
>
> Regards,
> Christian.
>
> Am 10.10.2016 um 22:21 schrieb StDenis, Tom:
>>
>> The only downside to taking the locks all the time is for 99% of 
>> debug reads it's unnecessary and in theory could lead to 
>> performance/behaviour problems.
>>
>>
>> I've been using this on read for a while now and haven't noticed a 
>> problem.
>>
>>
>> Tom
>>
>>
>>
>> ------------------------------------------------------------------------
>> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
>> *Sent:* Monday, October 10, 2016 09:49
>> *To:* Tom St Denis; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> *Cc:* StDenis, Tom
>> *Subject:* Re: [PATCH] drm/amd/amdgpu: Make debugfs write compliment 
>> read
>> Would it hurt us to always take the looks (both the pm as well as 
>> grbm idx lock)?
>>
>> I don't think that would be much of an issue and I would have a 
>> better feeling with that.
>>
>> Christian.
>>
>> Am 10.10.2016 um 15:38 schrieb Tom St Denis:
>>>
>>> that's kind of the point.  Its for debugging only.  Also reads can 
>>> already lock
>>>
>>>
>>> On Mon, Oct 10, 2016, 09:25 Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org 
>>> <mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>> wrote:
>>>
>>>     Mhm, that userspace controls if the lock is taken or not is a bit
>>>     problematic, on the other hand only root could access that.
>>>
>>>     Christian.
>>>
>>>     Am 10.10.2016 um 14:51 schrieb Tom St Denis:
>>>     > Add PG lock support as well as bank selection to
>>>     > the MMIO write function.
>>>     >
>>>     > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org
>>>     <mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org>>
>>>     > ---
>>>     >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 43
>>>     ++++++++++++++++++++++++++++++
>>>     >   1 file changed, 43 insertions(+)
>>>     >
>>>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > index 04c4aee70452..a9d83c1d7a43 100644
>>>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>     > @@ -2637,10 +2637,45 @@ static ssize_t
>>>     amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>>     >       struct amdgpu_device *adev = f->f_inode->i_private;
>>>     >       ssize_t result = 0;
>>>     >       int r;
>>>     > +     bool pm_pg_lock, use_bank;
>>>     > +     unsigned instance_bank, sh_bank, se_bank;
>>>     >
>>>     >       if (size & 0x3 || *pos & 0x3)
>>>     >               return -EINVAL;
>>>     >
>>>     > +     /* are we reading registers for which a PG lock is
>>>     necessary? */
>>>     > +     pm_pg_lock = (*pos >> 23) & 1;
>>>     > +
>>>     > +     if (*pos & (1ULL << 62)) {
>>>     > +             se_bank = (*pos >> 24) & 0x3FF;
>>>     > +             sh_bank = (*pos >> 34) & 0x3FF;
>>>     > +             instance_bank = (*pos >> 44) & 0x3FF;
>>>     > +
>>>     > +             if (se_bank == 0x3FF)
>>>     > +                     se_bank = 0xFFFFFFFF;
>>>     > +             if (sh_bank == 0x3FF)
>>>     > +                     sh_bank = 0xFFFFFFFF;
>>>     > +             if (instance_bank == 0x3FF)
>>>     > +                     instance_bank = 0xFFFFFFFF;
>>>     > +             use_bank = 1;
>>>     > +     } else {
>>>     > +             use_bank = 0;
>>>     > +     }
>>>     > +
>>>     > +     *pos &= 0x3FFFF;
>>>     > +
>>>     > +     if (use_bank) {
>>>     > +             if ((sh_bank != 0xFFFFFFFF && sh_bank >=
>>>     adev->gfx.config.max_sh_per_se) ||
>>>     > +                 (se_bank != 0xFFFFFFFF && se_bank >=
>>>     adev->gfx.config.max_shader_engines))
>>>     > +                     return -EINVAL;
>>>     > +  mutex_lock(&adev->grbm_idx_mutex);
>>>     > +  amdgpu_gfx_select_se_sh(adev, se_bank,
>>>     > +  sh_bank, instance_bank);
>>>     > +     }
>>>     > +
>>>     > +     if (pm_pg_lock)
>>>     > +  mutex_lock(&adev->pm.mutex);
>>>     > +
>>>     >       while (size) {
>>>     >               uint32_t value;
>>>     >
>>>     > @@ -2659,6 +2694,14 @@ static ssize_t
>>>     amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>>     >               size -= 4;
>>>     >       }
>>>     >
>>>     > +     if (use_bank) {
>>>     > +  amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
>>>     0xffffffff);
>>>     > +  mutex_unlock(&adev->grbm_idx_mutex);
>>>     > +     }
>>>     > +
>>>     > +     if (pm_pg_lock)
>>>     > +  mutex_unlock(&adev->pm.mutex);
>>>     > +
>>>     >       return result;
>>>     >   }
>>>     >
>>>
>>>
>>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------2E4B51A2E29BFEB0586C2D2A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Tom,<br>
      <br>
      yeah, the timing issue is a good argument. In this case just go
      ahead and add my Acked-by to the patch.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.10.2016 um 14:19 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768134851FB1F505F746843F7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Hi Christian,</p>
        <p><br>
        </p>
        <p>I agree with the crux of your argument but you can crash the
          system with carefully timed read/writes from the GFX
          registers, or MC, or ... That's why the entries are root only.</p>
        <p><br>
        </p>
        <p>The issue with locking excessively is you might change
          behaviour of something you're trying to debug because the
          kernel then has to wait on the lock (or you're waiting on the
          lock).  For instance, suppose you want to read DCE registers
          and the kernel is doing some gfx/grbm related your DCE read
          will either block the GFX activity or you're waiting on it
          which means the behaviour of the system could be different
          than from the case where you're not probing the registers.</p>
        <p><br>
        </p>
        <p>The goal is to be as unobtrusive as possible.  Heck I often
          mmap the BAR so I can read MMIO registers directly and not
          waste CPU cycles on syscalls.</p>
        <div><br>
        </div>
        The PM lock is because reading PGFSM registers during a
        powerup/down results in a GPU hang, and we only take the GRBM
        lock when users want to read from specific banks.  For any other
        case we don't need a lock.  In the kernel they should be
        mutually exclusive.  The PM lock is only taken in PP when
        performing a transition (or initializing the core) and I have
        yet to see a place where PP/PM related code also grabs the grbm
        index lock.
        <div><br>
        </div>
        <div>I don't have strong feelings against your proposal but I do
          prefer not to take the locks when I don't need to.  Ultimately
          I'll leave the decision up to you and Alex.  I'd like to get
          the 2nd patch through though as it makes the write side of the
          mmio reg complimentary (e.g. bank selection/pm lock).<br>
          <div><br>
          </div>
          <div>Cheers,</div>
          <div>Tom<br>
            <br>
            <div style="color: rgb(0, 0, 0);">
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="divRplyFwdMsg" dir="ltr"><font
                  style="font-size:11pt" color="#000000" face="Calibri,
                  sans-serif"><b>From:</b> Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                  <b>Sent:</b> Tuesday, October 11, 2016 08:11<br>
                  <b>To:</b> StDenis, Tom; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Make
                  debugfs write compliment read</font>
                <div> </div>
              </div>
              <div>
                <div class="moz-cite-prefix">
                  <blockquote type="cite">
                    <p>The only downside to taking the locks all the
                      time is for 99% of debug reads it's unnecessary
                      and in theory could lead to performance/behaviour
                      problems.</p>
                  </blockquote>
                  Yeah, but performance isn't critical here and taking
                  two locks compared to the rest of what we (IOCTL
                  etc...) do is completely negligibly.
                  <br>
                  <br>
                  <blockquote type="cite">
                    <p>I've been using this on read for a while now and
                      haven't noticed a problem.</p>
                  </blockquote>
                  My concern is rather that somebody tries to write to
                  the PM regs on accident or purpose without taking the
                  lock.<br>
                  <br>
                  See, the kernel is usually responsible to keep people
                  from doing stupid things with the hardware, even if
                  those people are root and could do stupid things
                  anyway. Well, you know what I mean?<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  Am 10.10.2016 um 22:21 schrieb StDenis, Tom:<br>
                </div>
                <blockquote type="cite">
                  <div id="divtagdefaultwrapper" style="font-size:12pt;
                    color:#000000;
                    font-family:Calibri,Arial,Helvetica,sans-serif">
                    <p>The only downside to taking the locks all the
                      time is for 99% of debug reads it's unnecessary
                      and in theory could lead to performance/behaviour
                      problems.</p>
                    <p><br>
                    </p>
                    <p>I've been using this on read for a while now and
                      haven't noticed a problem.</p>
                    <p><br>
                    </p>
                    <p>Tom</p>
                    <br>
                    <br>
                    <div style="color:rgb(0,0,0)">
                      <hr tabindex="-1" style="display:inline-block;
                        width:98%">
                      <div id="divRplyFwdMsg" dir="ltr"><font
                          style="font-size:11pt" color="#000000"
                          face="Calibri, sans-serif"><b>From:</b>
                          Christian König
                          <a moz-do-not-send="true"
                            class="moz-txt-link-rfc2396E"
                            href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                          <b>Sent:</b> Monday, October 10, 2016 09:49<br>
                          <b>To:</b> Tom St Denis; <a
                            moz-do-not-send="true"
                            class="moz-txt-link-abbreviated"
                            href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
                            amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                          <b>Cc:</b> StDenis, Tom<br>
                          <b>Subject:</b> Re: [PATCH] drm/amd/amdgpu:
                          Make debugfs write compliment read</font>
                        <div> </div>
                      </div>
                      <div>
                        <div class="moz-cite-prefix">Would it hurt us to
                          always take the looks (both the pm as well as
                          grbm idx lock)?<br>
                          <br>
                          I don't think that would be much of an issue
                          and I would have a better feeling with that.<br>
                          <br>
                          Christian.<br>
                          <br>
                          Am 10.10.2016 um 15:38 schrieb Tom St Denis:<br>
                        </div>
                        <blockquote type="cite">
                          <p dir="ltr">that's kind of the point.  Its
                            for debugging only.  Also reads can already
                            lock</p>
                          <br>
                          <div class="gmail_quote">
                            <div dir="ltr">On Mon, Oct 10, 2016, 09:25
                              Christian König &lt;<a
                                moz-do-not-send="true"
                                href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org</a>&gt;
                              wrote:<br>
                            </div>
                            <blockquote class="gmail_quote"
                              style="margin:0 0 0 .8ex; border-left:1px
                              #ccc solid; padding-left:1ex">
                              Mhm, that userspace controls if the lock
                              is taken or not is a bit<br
                                class="gmail_msg">
                              problematic, on the other hand only root
                              could access that.<br class="gmail_msg">
                              <br class="gmail_msg">
                              Christian.<br class="gmail_msg">
                              <br class="gmail_msg">
                              Am 10.10.2016 um 14:51 schrieb Tom St
                              Denis:<br class="gmail_msg">
                              &gt; Add PG lock support as well as bank
                              selection to<br class="gmail_msg">
                              &gt; the MMIO write function.<br
                                class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt; Signed-off-by: Tom St Denis &lt;<a
                                moz-do-not-send="true"
                                href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org"
                                class="gmail_msg" target="_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br
                                class="gmail_msg">
                              &gt; ---<br class="gmail_msg">
                              &gt; 
                               drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                              | 43 ++++++++++++++++++++++++++++++<br
                                class="gmail_msg">
                              &gt;   1 file changed, 43 insertions(+)<br
                                class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt; diff --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br class="gmail_msg">
                              &gt; index 04c4aee70452..a9d83c1d7a43
                              100644<br class="gmail_msg">
                              &gt; ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                                class="gmail_msg">
                              &gt; +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br
                                class="gmail_msg">
                              &gt; @@ -2637,10 +2637,45 @@ static
                              ssize_t amdgpu_debugfs_regs_write(struct
                              file *f, const char __user *buf,<br
                                class="gmail_msg">
                              &gt;       struct amdgpu_device *adev =
                              f-&gt;f_inode-&gt;i_private;<br
                                class="gmail_msg">
                              &gt;       ssize_t result = 0;<br
                                class="gmail_msg">
                              &gt;       int r;<br class="gmail_msg">
                              &gt; +     bool pm_pg_lock, use_bank;<br
                                class="gmail_msg">
                              &gt; +     unsigned instance_bank,
                              sh_bank, se_bank;<br class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt;       if (size &amp; 0x3 || *pos
                              &amp; 0x3)<br class="gmail_msg">
                              &gt;               return -EINVAL;<br
                                class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt; +     /* are we reading registers for
                              which a PG lock is necessary? */<br
                                class="gmail_msg">
                              &gt; +     pm_pg_lock = (*pos &gt;&gt; 23)
                              &amp; 1;<br class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +     if (*pos &amp; (1ULL &lt;&lt;
                              62)) {<br class="gmail_msg">
                              &gt; +             se_bank = (*pos
                              &gt;&gt; 24) &amp; 0x3FF;<br
                                class="gmail_msg">
                              &gt; +             sh_bank = (*pos
                              &gt;&gt; 34) &amp; 0x3FF;<br
                                class="gmail_msg">
                              &gt; +             instance_bank = (*pos
                              &gt;&gt; 44) &amp; 0x3FF;<br
                                class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +             if (se_bank == 0x3FF)<br
                                class="gmail_msg">
                              &gt; +                     se_bank =
                              0xFFFFFFFF;<br class="gmail_msg">
                              &gt; +             if (sh_bank == 0x3FF)<br
                                class="gmail_msg">
                              &gt; +                     sh_bank =
                              0xFFFFFFFF;<br class="gmail_msg">
                              &gt; +             if (instance_bank ==
                              0x3FF)<br class="gmail_msg">
                              &gt; +                     instance_bank =
                              0xFFFFFFFF;<br class="gmail_msg">
                              &gt; +             use_bank = 1;<br
                                class="gmail_msg">
                              &gt; +     } else {<br class="gmail_msg">
                              &gt; +             use_bank = 0;<br
                                class="gmail_msg">
                              &gt; +     }<br class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +     *pos &amp;= 0x3FFFF;<br
                                class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +     if (use_bank) {<br
                                class="gmail_msg">
                              &gt; +             if ((sh_bank !=
                              0xFFFFFFFF &amp;&amp; sh_bank &gt;=
                              adev-&gt;gfx.config.max_sh_per_se) ||<br
                                class="gmail_msg">
                              &gt; +                 (se_bank !=
                              0xFFFFFFFF &amp;&amp; se_bank &gt;=
                              adev-&gt;gfx.config.max_shader_engines))<br
                                class="gmail_msg">
                              &gt; +                     return -EINVAL;<br
                                class="gmail_msg">
                              &gt; +           
                               mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br
                                class="gmail_msg">
                              &gt; +           
                               amdgpu_gfx_select_se_sh(adev, se_bank,<br
                                class="gmail_msg">
                              &gt; +                                   
                               sh_bank, instance_bank);<br
                                class="gmail_msg">
                              &gt; +     }<br class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +     if (pm_pg_lock)<br
                                class="gmail_msg">
                              &gt; +           
                               mutex_lock(&amp;adev-&gt;pm.mutex);<br
                                class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt;       while (size) {<br
                                class="gmail_msg">
                              &gt;               uint32_t value;<br
                                class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt; @@ -2659,6 +2694,14 @@ static ssize_t
                              amdgpu_debugfs_regs_write(struct file *f,
                              const char __user *buf,<br
                                class="gmail_msg">
                              &gt;               size -= 4;<br
                                class="gmail_msg">
                              &gt;       }<br class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              &gt; +     if (use_bank) {<br
                                class="gmail_msg">
                              &gt; +           
                               amdgpu_gfx_select_se_sh(adev, 0xffffffff,
                              0xffffffff, 0xffffffff);<br
                                class="gmail_msg">
                              &gt; +           
                               mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br
                                class="gmail_msg">
                              &gt; +     }<br class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt; +     if (pm_pg_lock)<br
                                class="gmail_msg">
                              &gt; +           
                               mutex_unlock(&amp;adev-&gt;pm.mutex);<br
                                class="gmail_msg">
                              &gt; +<br class="gmail_msg">
                              &gt;       return result;<br
                                class="gmail_msg">
                              &gt;   }<br class="gmail_msg">
                              &gt;<br class="gmail_msg">
                              <br class="gmail_msg">
                              <br class="gmail_msg">
                            </blockquote>
                          </div>
                        </blockquote>
                        <p><br>
                        </p>
                      </div>
                    </div>
                  </div>
                </blockquote>
                <p><br>
                </p>
              </div>
            </div>
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
    <p><br>
    </p>
  </body>
</html>

--------------2E4B51A2E29BFEB0586C2D2A--

--===============0092430761==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0092430761==--
