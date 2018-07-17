From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/pm: Remove VLA usage
Date: Tue, 17 Jul 2018 08:58:21 +0200
Message-ID: <42ba5486-34a2-02bd-50a1-12314e6e2755@gmail.com>
References: <20180620182647.GA24405@beast>
 <CAGXu5jK74ew7iTw2_OqJSj4wYjBggPpkN-ENEFRpuq0C-eGRDg@mail.gmail.com>
 <CY4PR12MB16874F4DB841A96E065E94EEFB5C0@CY4PR12MB1687.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1584869283=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16874F4DB841A96E065E94EEFB5C0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, Maling list - DRI developers <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1584869283==
Content-Type: multipart/alternative;
 boundary="------------EE817BF33AD9A922A5D68A8E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------EE817BF33AD9A922A5D68A8E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

> Who's tree should this go through?
To answer the question: When Rex is ok with that he pushes it to our 
internal amd-staging-drm-next tree.

Alex then pushes that tree to a public server and at some point sends a 
pull request for inclusion in drm-next.

Regards,
Christian.

Am 17.07.2018 um 08:23 schrieb Zhu, Rex:
> Patch is:
> Reviewed-by: Rex Zhu<rezhu-5C7GfCeVMHo@public.gmane.org <mailto:rezhu-5C7GfCeVMHo@public.gmane.org>>
>
>
>
> Best Regards
> Rex
>
>
> ------------------------------------------------------------------------
> *From:* keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org <keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org> on behalf of Kees 
> Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> *Sent:* Tuesday, July 17, 2018 11:59 AM
> *To:* Deucher, Alexander
> *Cc:* LKML; Koenig, Christian; Zhou, David(ChunMing); David Airlie; 
> Zhu, Rex; Huang, Ray; Kuehling, Felix; amd-gfx list; Maling list - DRI 
> developers
> *Subject:* Re: [PATCH] drm/amdgpu/pm: Remove VLA usage
> On Wed, Jun 20, 2018 at 11:26 AM, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
> > In the quest to remove all stack VLA usage from the kernel[1], this
> > uses the maximum sane buffer size and removes copy/paste code.
> >
> > [1] 
> https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org
> >
> > Signed-off-by: Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>
> Friendly ping! Who's tree should this go through?
>
> Thanks!
>
> -Kees
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100 +++++++++++--------------
> >  1 file changed, 42 insertions(+), 58 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > index b455da487782..5eb98cde22ed 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
> > @@ -593,40 +593,59 @@ static ssize_t amdgpu_get_pp_dpm_sclk(struct 
> device *dev,
> >                 return snprintf(buf, PAGE_SIZE, "\n");
> >  }
> >
> > -static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> > -               struct device_attribute *attr,
> > -               const char *buf,
> > -               size_t count)
> > +/*
> > + * Worst case: 32 bits individually specified, in octal at 12 
> characters
> > + * per line (+1 for \n).
> > + */
> > +#define AMDGPU_MASK_BUF_MAX    (32 * 13)
> > +
> > +static ssize_t amdgpu_read_mask(const char *buf, size_t count, 
> uint32_t *mask)
> >  {
> > -       struct drm_device *ddev = dev_get_drvdata(dev);
> > -       struct amdgpu_device *adev = ddev->dev_private;
> >         int ret;
> >         long level;
> > -       uint32_t mask = 0;
> >         char *sub_str = NULL;
> >         char *tmp;
> > -       char buf_cpy[count];
> > +       char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];
> >         const char delimiter[3] = {' ', '\n', '\0'};
> > +       size_t bytes;
> >
> > -       memcpy(buf_cpy, buf, count+1);
> > +       *mask = 0;
> > +
> > +       bytes = min(count, sizeof(buf_cpy) - 1);
> > +       memcpy(buf_cpy, buf, bytes);
> > +       buf_cpy[bytes] = '\0';
> >         tmp = buf_cpy;
> >         while (tmp[0]) {
> > -               sub_str =  strsep(&tmp, delimiter);
> > +               sub_str = strsep(&tmp, delimiter);
> >                 if (strlen(sub_str)) {
> >                         ret = kstrtol(sub_str, 0, &level);
> > -
> > -                       if (ret) {
> > -                               count = -EINVAL;
> > -                               goto fail;
> > -                       }
> > -                       mask |= 1 << level;
> > +                       if (ret)
> > +                               return -EINVAL;
> > +                       *mask |= 1 << level;
> >                 } else
> >                         break;
> >         }
> > +
> > +       return 0;
> > +}
> > +
> > +static ssize_t amdgpu_set_pp_dpm_sclk(struct device *dev,
> > +               struct device_attribute *attr,
> > +               const char *buf,
> > +               size_t count)
> > +{
> > +       struct drm_device *ddev = dev_get_drvdata(dev);
> > +       struct amdgpu_device *adev = ddev->dev_private;
> > +       int ret;
> > +       uint32_t mask = 0;
> > +
> > +       ret = amdgpu_read_mask(buf, count, &mask);
> > +       if (ret)
> > +               return ret;
> > +
> >         if (adev->powerplay.pp_funcs->force_clock_level)
> > amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);
> >
> > -fail:
> >         return count;
> >  }
> >
> > @@ -651,32 +670,15 @@ static ssize_t amdgpu_set_pp_dpm_mclk(struct 
> device *dev,
> >         struct drm_device *ddev = dev_get_drvdata(dev);
> >         struct amdgpu_device *adev = ddev->dev_private;
> >         int ret;
> > -       long level;
> >         uint32_t mask = 0;
> > -       char *sub_str = NULL;
> > -       char *tmp;
> > -       char buf_cpy[count];
> > -       const char delimiter[3] = {' ', '\n', '\0'};
> >
> > -       memcpy(buf_cpy, buf, count+1);
> > -       tmp = buf_cpy;
> > -       while (tmp[0]) {
> > -               sub_str =  strsep(&tmp, delimiter);
> > -               if (strlen(sub_str)) {
> > -                       ret = kstrtol(sub_str, 0, &level);
> > +       ret = amdgpu_read_mask(buf, count, &mask);
> > +       if (ret)
> > +               return ret;
> >
> > -                       if (ret) {
> > -                               count = -EINVAL;
> > -                               goto fail;
> > -                       }
> > -                       mask |= 1 << level;
> > -               } else
> > -                       break;
> > -       }
> >         if (adev->powerplay.pp_funcs->force_clock_level)
> > amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);
> >
> > -fail:
> >         return count;
> >  }
> >
> > @@ -701,33 +703,15 @@ static ssize_t amdgpu_set_pp_dpm_pcie(struct 
> device *dev,
> >         struct drm_device *ddev = dev_get_drvdata(dev);
> >         struct amdgpu_device *adev = ddev->dev_private;
> >         int ret;
> > -       long level;
> >         uint32_t mask = 0;
> > -       char *sub_str = NULL;
> > -       char *tmp;
> > -       char buf_cpy[count];
> > -       const char delimiter[3] = {' ', '\n', '\0'};
> > -
> > -       memcpy(buf_cpy, buf, count+1);
> > -       tmp = buf_cpy;
> >
> > -       while (tmp[0]) {
> > -               sub_str =  strsep(&tmp, delimiter);
> > -               if (strlen(sub_str)) {
> > -                       ret = kstrtol(sub_str, 0, &level);
> > +       ret = amdgpu_read_mask(buf, count, &mask);
> > +       if (ret)
> > +               return ret;
> >
> > -                       if (ret) {
> > -                               count = -EINVAL;
> > -                               goto fail;
> > -                       }
> > -                       mask |= 1 << level;
> > -               } else
> > -                       break;
> > -       }
> >         if (adev->powerplay.pp_funcs->force_clock_level)
> > amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);
> >
> > -fail:
> >         return count;
> >  }
> >
> > --
> > 2.17.1
> >
> >
> > --
> > Kees Cook
> > Pixel Security
>
>
>
> -- 
> Kees Cook
> Pixel Security
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------EE817BF33AD9A922A5D68A8E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite"><font size="2"><span
            style="font-size:11pt;">Who's tree should this go through?</span></font></blockquote>
      To answer the question: When Rex is ok with that he pushes it to
      our internal amd-staging-drm-next tree.<br>
      <br>
      Alex then pushes that tree to a public server and at some point
      sends a pull request for inclusion in drm-next.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 17.07.2018 um 08:23 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB16874F4DB841A96E065E94EEFB5C0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <div dir="auto" style="direction: ltr; margin: 0px; padding:
          0px; font-family: sans-serif, serif, &quot;EmojiFont&quot;;
          font-size: 11pt; color: black;">
          Patch is:<br>
          Reviewed-by: Rex Zhu&lt;<a href="mailto:rezhu-5C7GfCeVMHo@public.gmane.org"
            target="_blank" rel="noopener noreferrer"
            data-auth="NotApplicable" id="LPlnk600685"
            class="OWAAutoLink" previewremoved="true"
            moz-do-not-send="true">rezhu-5C7GfCeVMHo@public.gmane.org</a>&gt; <br>
          <br>
          <br>
          <br>
        </div>
        <div align="left">
          <div dir="auto" style="direction: ltr; margin: 0px; padding:
            0px; font-family: sans-serif, serif, &quot;EmojiFont&quot;;
            font-size: 11pt; color: black;">
            <font color="#000000">Best Regards</font><br>
          </div>
        </div>
        <font color="#000000">Rex</font><br>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              <a class="moz-txt-link-abbreviated" href="mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org</a> <a class="moz-txt-link-rfc2396E" href="mailto:keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org">&lt;keescook-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org&gt;</a> on behalf
              of Kees Cook <a class="moz-txt-link-rfc2396E" href="mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Tuesday, July 17, 2018 11:59 AM<br>
              <b>To:</b> Deucher, Alexander<br>
              <b>Cc:</b> LKML; Koenig, Christian; Zhou, David(ChunMing);
              David Airlie; Zhu, Rex; Huang, Ray; Kuehling, Felix;
              amd-gfx list; Maling list - DRI developers<br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu/pm: Remove VLA
              usage</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">On Wed, Jun 20, 2018 at 11:26 AM,
                  Kees Cook <a class="moz-txt-link-rfc2396E" href="mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a> wrote:<br>
                  &gt; In the quest to remove all stack VLA usage from
                  the kernel[1], this<br>
                  &gt; uses the maximum sane buffer size and removes
                  copy/paste code.<br>
                  &gt;<br>
                  &gt; [1] <a
href="https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org"
                    id="LPlnk141741" class="OWAAutoLink"
                    previewremoved="true" moz-do-not-send="true">
https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org</a><br>
                  &gt;<br>
                  &gt; Signed-off-by: Kees Cook
                  <a class="moz-txt-link-rfc2396E" href="mailto:keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org">&lt;keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org&gt;</a><br>
                  <br>
                  Friendly ping! Who's tree should this go through?<br>
                  <br>
                  Thanks!<br>
                  <br>
                  -Kees<br>
                  <br>
                  &gt; ---<br>
                  &gt;  drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 100
                  +++++++++++--------------<br>
                  &gt;  1 file changed, 42 insertions(+), 58
                  deletions(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
                  &gt; index b455da487782..5eb98cde22ed 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c<br>
                  &gt; @@ -593,40 +593,59 @@ static ssize_t
                  amdgpu_get_pp_dpm_sclk(struct device *dev,<br>
                  &gt;                 return snprintf(buf, PAGE_SIZE,
                  "\n");<br>
                  &gt;  }<br>
                  &gt;<br>
                  &gt; -static ssize_t amdgpu_set_pp_dpm_sclk(struct
                  device *dev,<br>
                  &gt; -               struct device_attribute *attr,<br>
                  &gt; -               const char *buf,<br>
                  &gt; -               size_t count)<br>
                  &gt; +/*<br>
                  &gt; + * Worst case: 32 bits individually specified,
                  in octal at 12 characters<br>
                  &gt; + * per line (+1 for \n).<br>
                  &gt; + */<br>
                  &gt; +#define AMDGPU_MASK_BUF_MAX    (32 * 13)<br>
                  &gt; +<br>
                  &gt; +static ssize_t amdgpu_read_mask(const char *buf,
                  size_t count, uint32_t *mask)<br>
                  &gt;  {<br>
                  &gt; -       struct drm_device *ddev =
                  dev_get_drvdata(dev);<br>
                  &gt; -       struct amdgpu_device *adev =
                  ddev-&gt;dev_private;<br>
                  &gt;         int ret;<br>
                  &gt;         long level;<br>
                  &gt; -       uint32_t mask = 0;<br>
                  &gt;         char *sub_str = NULL;<br>
                  &gt;         char *tmp;<br>
                  &gt; -       char buf_cpy[count];<br>
                  &gt; +       char buf_cpy[AMDGPU_MASK_BUF_MAX + 1];<br>
                  &gt;         const char delimiter[3] = {' ', '\n',
                  '\0'};<br>
                  &gt; +       size_t bytes;<br>
                  &gt;<br>
                  &gt; -       memcpy(buf_cpy, buf, count+1);<br>
                  &gt; +       *mask = 0;<br>
                  &gt; +<br>
                  &gt; +       bytes = min(count, sizeof(buf_cpy) - 1);<br>
                  &gt; +       memcpy(buf_cpy, buf, bytes);<br>
                  &gt; +       buf_cpy[bytes] = '\0';<br>
                  &gt;         tmp = buf_cpy;<br>
                  &gt;         while (tmp[0]) {<br>
                  &gt; -               sub_str =  strsep(&amp;tmp,
                  delimiter);<br>
                  &gt; +               sub_str = strsep(&amp;tmp,
                  delimiter);<br>
                  &gt;                 if (strlen(sub_str)) {<br>
                  &gt;                         ret = kstrtol(sub_str, 0,
                  &amp;level);<br>
                  &gt; -<br>
                  &gt; -                       if (ret) {<br>
                  &gt; -                               count = -EINVAL;<br>
                  &gt; -                               goto fail;<br>
                  &gt; -                       }<br>
                  &gt; -                       mask |= 1 &lt;&lt; level;<br>
                  &gt; +                       if (ret)<br>
                  &gt; +                               return -EINVAL;<br>
                  &gt; +                       *mask |= 1 &lt;&lt;
                  level;<br>
                  &gt;                 } else<br>
                  &gt;                         break;<br>
                  &gt;         }<br>
                  &gt; +<br>
                  &gt; +       return 0;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static ssize_t amdgpu_set_pp_dpm_sclk(struct
                  device *dev,<br>
                  &gt; +               struct device_attribute *attr,<br>
                  &gt; +               const char *buf,<br>
                  &gt; +               size_t count)<br>
                  &gt; +{<br>
                  &gt; +       struct drm_device *ddev =
                  dev_get_drvdata(dev);<br>
                  &gt; +       struct amdgpu_device *adev =
                  ddev-&gt;dev_private;<br>
                  &gt; +       int ret;<br>
                  &gt; +       uint32_t mask = 0;<br>
                  &gt; +<br>
                  &gt; +       ret = amdgpu_read_mask(buf, count,
                  &amp;mask);<br>
                  &gt; +       if (ret)<br>
                  &gt; +               return ret;<br>
                  &gt; +<br>
                  &gt;         if
                  (adev-&gt;powerplay.pp_funcs-&gt;force_clock_level)<br>
                  &gt;                
                  amdgpu_dpm_force_clock_level(adev, PP_SCLK, mask);<br>
                  &gt;<br>
                  &gt; -fail:<br>
                  &gt;         return count;<br>
                  &gt;  }<br>
                  &gt;<br>
                  &gt; @@ -651,32 +670,15 @@ static ssize_t
                  amdgpu_set_pp_dpm_mclk(struct device *dev,<br>
                  &gt;         struct drm_device *ddev =
                  dev_get_drvdata(dev);<br>
                  &gt;         struct amdgpu_device *adev =
                  ddev-&gt;dev_private;<br>
                  &gt;         int ret;<br>
                  &gt; -       long level;<br>
                  &gt;         uint32_t mask = 0;<br>
                  &gt; -       char *sub_str = NULL;<br>
                  &gt; -       char *tmp;<br>
                  &gt; -       char buf_cpy[count];<br>
                  &gt; -       const char delimiter[3] = {' ', '\n',
                  '\0'};<br>
                  &gt;<br>
                  &gt; -       memcpy(buf_cpy, buf, count+1);<br>
                  &gt; -       tmp = buf_cpy;<br>
                  &gt; -       while (tmp[0]) {<br>
                  &gt; -               sub_str =  strsep(&amp;tmp,
                  delimiter);<br>
                  &gt; -               if (strlen(sub_str)) {<br>
                  &gt; -                       ret = kstrtol(sub_str, 0,
                  &amp;level);<br>
                  &gt; +       ret = amdgpu_read_mask(buf, count,
                  &amp;mask);<br>
                  &gt; +       if (ret)<br>
                  &gt; +               return ret;<br>
                  &gt;<br>
                  &gt; -                       if (ret) {<br>
                  &gt; -                               count = -EINVAL;<br>
                  &gt; -                               goto fail;<br>
                  &gt; -                       }<br>
                  &gt; -                       mask |= 1 &lt;&lt; level;<br>
                  &gt; -               } else<br>
                  &gt; -                       break;<br>
                  &gt; -       }<br>
                  &gt;         if
                  (adev-&gt;powerplay.pp_funcs-&gt;force_clock_level)<br>
                  &gt;                
                  amdgpu_dpm_force_clock_level(adev, PP_MCLK, mask);<br>
                  &gt;<br>
                  &gt; -fail:<br>
                  &gt;         return count;<br>
                  &gt;  }<br>
                  &gt;<br>
                  &gt; @@ -701,33 +703,15 @@ static ssize_t
                  amdgpu_set_pp_dpm_pcie(struct device *dev,<br>
                  &gt;         struct drm_device *ddev =
                  dev_get_drvdata(dev);<br>
                  &gt;         struct amdgpu_device *adev =
                  ddev-&gt;dev_private;<br>
                  &gt;         int ret;<br>
                  &gt; -       long level;<br>
                  &gt;         uint32_t mask = 0;<br>
                  &gt; -       char *sub_str = NULL;<br>
                  &gt; -       char *tmp;<br>
                  &gt; -       char buf_cpy[count];<br>
                  &gt; -       const char delimiter[3] = {' ', '\n',
                  '\0'};<br>
                  &gt; -<br>
                  &gt; -       memcpy(buf_cpy, buf, count+1);<br>
                  &gt; -       tmp = buf_cpy;<br>
                  &gt;<br>
                  &gt; -       while (tmp[0]) {<br>
                  &gt; -               sub_str =  strsep(&amp;tmp,
                  delimiter);<br>
                  &gt; -               if (strlen(sub_str)) {<br>
                  &gt; -                       ret = kstrtol(sub_str, 0,
                  &amp;level);<br>
                  &gt; +       ret = amdgpu_read_mask(buf, count,
                  &amp;mask);<br>
                  &gt; +       if (ret)<br>
                  &gt; +               return ret;<br>
                  &gt;<br>
                  &gt; -                       if (ret) {<br>
                  &gt; -                               count = -EINVAL;<br>
                  &gt; -                               goto fail;<br>
                  &gt; -                       }<br>
                  &gt; -                       mask |= 1 &lt;&lt; level;<br>
                  &gt; -               } else<br>
                  &gt; -                       break;<br>
                  &gt; -       }<br>
                  &gt;         if
                  (adev-&gt;powerplay.pp_funcs-&gt;force_clock_level)<br>
                  &gt;                
                  amdgpu_dpm_force_clock_level(adev, PP_PCIE, mask);<br>
                  &gt;<br>
                  &gt; -fail:<br>
                  &gt;         return count;<br>
                  &gt;  }<br>
                  &gt;<br>
                  &gt; --<br>
                  &gt; 2.17.1<br>
                  &gt;<br>
                  &gt;<br>
                  &gt; --<br>
                  &gt; Kees Cook<br>
                  &gt; Pixel Security<br>
                  <br>
                  <br>
                  <br>
                  -- <br>
                  Kees Cook<br>
                  Pixel Security<br>
                </div>
              </span></font></div>
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

--------------EE817BF33AD9A922A5D68A8E--

--===============1584869283==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1584869283==--
