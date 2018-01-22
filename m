From: Andrey Grodzovsky <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 15/24] drm/amd/display: Fix deadlock when flushing irq
Date: Mon, 22 Jan 2018 09:57:01 -0500
Message-ID: <a5d20d38-760e-a4ef-5f79-8774e70f3a4c@amd.com>
References: <20180118210353.18842-1-harry.wentland@amd.com>
 <20180118210353.18842-16-harry.wentland@amd.com>
 <2996fec0-814d-ec58-788b-883df20d2651@amd.com>
 <BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0@BN6PR1201MB0100.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1635391673=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0-6iU6OBHu2P8MZuswy4CCPGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Lipski, Mikita" <Mikita.Lipski-5C7GfCeVMHo@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1635391673==
Content-Type: multipart/alternative;
 boundary="------------8E1F280F99842FD1ABDEE200"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8E1F280F99842FD1ABDEE200
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

You guys just need to revert it on dal-dev branch and don't promote to 
amd-staging-drm-next.


So NAK for the change.



Thanks,

Andrey


On 01/22/2018 09:38 AM, Lipski, Mikita wrote:
>
> Hi Andrey,
>
>
> I've checked to revert this change and use Alex's change on switching 
> irq destruction sequence and it worked no problem.
> You can reject this change if Alex's change is pulled in.
>
>
> Thanks,
>
> Nick
>
> ------------------------------------------------------------------------
> *From:* Grodzovsky, Andrey
> *Sent:* Friday, January 19, 2018 1:33:51 PM
> *To:* Wentland, Harry; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Lipski, Mikita
> *Subject:* Re: [PATCH 15/24] drm/amd/display: Fix deadlock when 
> flushing irq
> What this spin lock is protecting here ? Seems to me it's just a read of
> an array element which is always there.
>
> Regarding subsequent remove_timer_handler and timer queue destruction it
> seems to me to be obsolete code, I don't think DAL is still using the
> timer queue,
>
> so seems to me everything related to it should be removed.
>
> Thanks,
>
> Andrey
>
>
> On 01/18/2018 04:03 PM, Harry Wentland wrote:
> > From: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
> >
> > Lock irq table when reading a work in queue,
> > unlock to flush the work, lock again till all tasks
> > are cleared
> >
> > Signed-off-by: Mikita Lipski <mikita.lipski-5C7GfCeVMHo@public.gmane.org>
> > Reviewed-by: Harry Wentland <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>
> > ---
> > drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > index 1874b6cee6af..fb60c91a1bfe 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> > @@ -400,14 +400,15 @@ void amdgpu_dm_irq_fini(struct amdgpu_device 
> *adev)
> >   {
> >        int src;
> >        struct irq_list_head *lh;
> > +     unsigned long irq_table_flags;
> >        DRM_DEBUG_KMS("DM_IRQ: releasing resources.\n");
> > -
> >        for (src = 0; src < DAL_IRQ_SOURCES_NUMBER; src++) {
> > -
> > +             DM_IRQ_TABLE_LOCK(adev, irq_table_flags);
> >                /* The handler was removed from the table,
> >                 * it means it is safe to flush all the 'work'
> >                 * (because no code can schedule a new one). */
> >                lh = &adev->dm.irq_handler_list_low_tab[src];
> > +             DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
> >                flush_work(&lh->work);
> >        }
> >
>


--------------8E1F280F99842FD1ABDEE200
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>You guys just need to revert it on dal-dev branch and don't
      promote to amd-staging-drm-next.</p>
    <p><br>
    </p>
    <p>So NAK for the change.</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <p>Thanks,</p>
    <p>Andrey<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 01/22/2018 09:38 AM, Lipski, Mikita
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR1201MB0100D9415FC07D00CBE859CCE4EF0-6iU6OBHu2P8MZuswy4CCPGrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
        rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
        &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
        &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
        Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
        dir="ltr">
        <div id="divtagdefaultwrapper" style="font-size: 12pt; color:
          rgb(0, 0, 0); font-family: Calibri, Helvetica, sans-serif,
          &quot;EmojiFont&quot;, &quot;Apple Color Emoji&quot;,
          &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &quot;Segoe UI
          Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;"
          dir="ltr">
          <div>
            <p style="margin-top:0;margin-bottom:0">Hi Andrey,</p>
            <p style="margin-top:0;margin-bottom:0"><br>
            </p>
            I've checked to revert this change and use Alex's change on
            switching irq destruction sequence and it worked no
            problem. 
          </div>
          You can reject this change if Alex's change is pulled in.
          <p style="margin-top:0;margin-bottom:0"><br>
          </p>
          <p style="margin-top:0;margin-bottom:0">Thanks,</p>
          <p style="margin-top:0;margin-bottom:0">Nick<br>
          </p>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>From:</b>
            Grodzovsky, Andrey<br>
            <b>Sent:</b> Friday, January 19, 2018 1:33:51 PM<br>
            <b>To:</b> Wentland, Harry; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>Cc:</b> Lipski, Mikita<br>
            <b>Subject:</b> Re: [PATCH 15/24] drm/amd/display: Fix
            deadlock when flushing irq</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">What this spin lock is protecting
                here ? Seems to me it's just a read of
                <br>
                an array element which is always there.<br>
                <br>
                Regarding subsequent remove_timer_handler and timer
                queue destruction it <br>
                seems to me to be obsolete code, I don't think DAL is
                still using the <br>
                timer queue,<br>
                <br>
                so seems to me everything related to it should be
                removed.<br>
                <br>
                Thanks,<br>
                <br>
                Andrey<br>
                <br>
                <br>
                On 01/18/2018 04:03 PM, Harry Wentland wrote:<br>
                &gt; From: Mikita Lipski <a class="moz-txt-link-rfc2396E" href="mailto:mikita.lipski-5C7GfCeVMHo@public.gmane.org">&lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;<br>
                &gt; Lock irq table when reading a work in queue,<br>
                &gt; unlock to flush the work, lock again till all tasks<br>
                &gt; are cleared<br>
                &gt;<br>
                &gt; Signed-off-by: Mikita Lipski
                <a class="moz-txt-link-rfc2396E" href="mailto:mikita.lipski-5C7GfCeVMHo@public.gmane.org">&lt;mikita.lipski-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; Reviewed-by: Harry Wentland
                <a class="moz-txt-link-rfc2396E" href="mailto:Harry.Wentland-5C7GfCeVMHo@public.gmane.org">&lt;Harry.Wentland-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt; ---<br>
                &gt;  
                drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |
                5 +++--<br>
                &gt;   1 file changed, 3 insertions(+), 2 deletions(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
                &gt; index 1874b6cee6af..fb60c91a1bfe 100644<br>
                &gt; ---
                a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
                &gt; +++
                b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c<br>
                &gt; @@ -400,14 +400,15 @@ void
                amdgpu_dm_irq_fini(struct amdgpu_device *adev)<br>
                &gt;   {<br>
                &gt;        int src;<br>
                &gt;        struct irq_list_head *lh;<br>
                &gt; +     unsigned long irq_table_flags;<br>
                &gt;        DRM_DEBUG_KMS("DM_IRQ: releasing
                resources.\n");<br>
                &gt; -<br>
                &gt;        for (src = 0; src &lt;
                DAL_IRQ_SOURCES_NUMBER; src++) {<br>
                &gt; -<br>
                &gt; +             DM_IRQ_TABLE_LOCK(adev,
                irq_table_flags);<br>
                &gt;                /* The handler was removed from the
                table,<br>
                &gt;                 * it means it is safe to flush all
                the 'work'<br>
                &gt;                 * (because no code can schedule a
                new one). */<br>
                &gt;                lh =
                &amp;adev-&gt;dm.irq_handler_list_low_tab[src];<br>
                &gt; +             DM_IRQ_TABLE_UNLOCK(adev,
                irq_table_flags);<br>
                &gt;                flush_work(&amp;lh-&gt;work);<br>
                &gt;        }<br>
                &gt;   <br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8E1F280F99842FD1ABDEE200--

--===============1635391673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1635391673==--
