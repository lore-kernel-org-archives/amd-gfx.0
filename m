From: Samantha McVey <samantham-VwIFZPTo/vqsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Don't load DMCU for Raven 1 (v2)
Date: Thu, 30 May 2019 16:40:58 +0200
Message-ID: <1791409.jyYnDiAcy6@linux-5702>
References: <20190524153410.19402-1-alexander.deucher@amd.com>
 <CAHbf0-EYvnaVmqB068CA9hi3Wt7U2a387n6SCUdw8sUjouayZQ@mail.gmail.com>
 <CADnq5_N48x5Zas_HWTN1JdEgUUmFadsSiu5_1uZmRgaDw+qraw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0051126636=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N48x5Zas_HWTN1JdEgUUmFadsSiu5_1uZmRgaDw+qraw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.

--===============0051126636==
Content-Type: multipart/alternative; boundary="nextPart2424465.qbV5PHHhLX"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2424465.qbV5PHHhLX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Alex,

Are any of these non-booting systems laptops? If all the laptops don't have this issue, is 
there a way we can detect we are on mobile and load the DMCU? Seeing as ABM and PSR 
are both practically only used on mobile, maybe we can check for that. This way we only 
enable it on systems that actually need the features. I am guessing the number of Raven 
Ridge laptops is much much smaller than the number of motherboards which can 
potentially support Raven Ridge.

On vrijdag 24 mei 2019 18:49:27 CEST you wrote:
> On Fri, May 24, 2019 at 12:32 PM Mike Lothian <mike at fireburn.co.uk> wrote:
> > I realise you don't want to enable this as it's breaking some people's
> > systems, but could we add a new boot parameter to force it for working
> > systems? Or check against a black list maybe?
> 
> We could probably add a whitelist.  I'm not sure what the best way to
> id the working systems are though.
> 
> Alex
> 
> > On Fri, 24 May 2019 at 17:20, Alex Deucher <alexdeucher at gmail.com> wrote:
> > > On Fri, May 24, 2019 at 12:09 PM Mike Lothian <mike at fireburn.co.uk> wrote:
> > > > Hi
> > > > 
> > > > Curious to know what this means for folk that have newer Raven1 boards
> > > > that didn't have issues loading the firmware
> > > 
> > > You won't get ABM I think.  ABM is the automatic backlight management.
> > > 
> > > Alex
> > > 
> > > > Cheers
> > > > 
> > > > Mike
> > > > 
> > > > On Fri, 24 May 2019 at 16:34, Alex Deucher <alexdeucher at gmail.com> wrote:
> > > > > From: Harry Wentland <harry.wentland at amd.com>
> > > > > 
> > > > > [WHY]
> > > > > Some early Raven boards had a bad SBIOS that doesn't play nicely
> > > > > with
> > > > > the DMCU FW. We thought the issues were fixed by ignoring errors on
> > > > > DMCU
> > > > > load but that doesn't seem to be the case. We've still seen reports
> > > > > of
> > > > > users unable to boot their systems at all.
> > > > > 
> > > > > [HOW]
> > > > > Disable DMCU load on Raven 1. Only load it for Raven 2 and Picasso.
> > > > > 
> > > > > v2: Fix ifdef (Alex)
> > > > > 
> > > > > Signed-off-by: Harry Wentland <harry.wentland at amd.com>
> > > > > Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas at amd.com>
> > > > > Signed-off-by: Alex Deucher <alexander.deucher at amd.com>
> > > > > Cc: stable at vger.kernel.org
> > > > > ---
> > > > > 
> > > > >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index
> > > > > 995f9df66142..bcb1a93c0b4c 100644
> > > > > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > > > > @@ -29,6 +29,7 @@
> > > > > 
> > > > >  #include "dm_services_types.h"
> > > > >  #include "dc.h"
> > > > >  #include "dc/inc/core_types.h"
> > > > > 
> > > > > +#include "dal_asic_id.h"
> > > > > 
> > > > >  #include "vid.h"
> > > > >  #include "amdgpu.h"
> > > > > 
> > > > > @@ -640,7 +641,7 @@ static void amdgpu_dm_fini(struct amdgpu_device
> > > > > *adev)
> > > > > 
> > > > >  static int load_dmcu_fw(struct amdgpu_device *adev)
> > > > >  {
> > > > > 
> > > > > -       const char *fw_name_dmcu;
> > > > > +       const char *fw_name_dmcu = NULL;
> > > > > 
> > > > >         int r;
> > > > >         const struct dmcu_firmware_header_v1_0 *hdr;
> > > > > 
> > > > > @@ -663,7 +664,14 @@ static int load_dmcu_fw(struct amdgpu_device
> > > > > *adev)
> > > > > 
> > > > >         case CHIP_VEGA20:
> > > > >                 return 0;
> > > > >         
> > > > >         case CHIP_RAVEN:
> > > > > -               fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> > > > > +#if defined(CONFIG_DRM_AMD_DC_DCN1_01)
> > > > > +               if (ASICREV_IS_PICASSO(adev->external_rev_id))
> > > > > +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> > > > > +               else if (ASICREV_IS_RAVEN2(adev->external_rev_id))
> > > > > +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;
> > > > > +               else
> > > > > +#endif
> > > > > +                       return 0;
> > > > > 
> > > > >                 break;
> > > > >         
> > > > >         default:
> > > > >                 DRM_ERROR("Unsupported ASIC type: 0x%X\n",
> > > > >                 adev->asic_type);
> > > > > 
--nextPart2424465.qbV5PHHhLX
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html><head><meta name="qrichtext" content="1" /><style type="text/css">
p, li { white-space: pre-wrap; }
</style></head><body style=" font-family:'Noto Sans'; font-size:9pt; font-weight:400; font-style:normal;">
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Alex,</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">Are any of these non-booting systems laptops? If all the laptops don't have this issue, is there a way we can detect we are on mobile and load the DMCU? Seeing as ABM and PSR are both practically only used on mobile, maybe we can check for that. This way we only enable it on systems that actually need the features. I am guessing the number of Raven Ridge laptops is much much smaller than the number of motherboards which can potentially support Raven Ridge.</p>
<p style="-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; ">&nbsp;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">On vrijdag 24 mei 2019 18:49:27 CEST you wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; On Fri, May 24, 2019 at 12:32 PM Mike Lothian &lt;mike at fireburn.co.uk&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; I realise you don't want to enable this as it's breaking some people's</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; systems, but could we add a new boot parameter to force it for working</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; systems? Or check against a black list maybe?</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; We could probably add a whitelist.  I'm not sure what the best way to</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; id the working systems are though.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; Alex</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; On Fri, 24 May 2019 at 17:20, Alex Deucher &lt;alexdeucher at gmail.com&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; On Fri, May 24, 2019 at 12:09 PM Mike Lothian &lt;mike at fireburn.co.uk&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; Hi</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; Curious to know what this means for folk that have newer Raven1 boards</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; that didn't have issues loading the firmware</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; You won't get ABM I think.  ABM is the automatic backlight management.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; Alex</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; Cheers</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; Mike</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; On Fri, 24 May 2019 at 16:34, Alex Deucher &lt;alexdeucher at gmail.com&gt; wrote:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; From: Harry Wentland &lt;harry.wentland at amd.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; [WHY]</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Some early Raven boards had a bad SBIOS that doesn't play nicely</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; with</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; the DMCU FW. We thought the issues were fixed by ignoring errors on</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; DMCU</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; load but that doesn't seem to be the case. We've still seen reports</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; of</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; users unable to boot their systems at all.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; [HOW]</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Disable DMCU load on Raven 1. Only load it for Raven 2 and Picasso.</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; v2: Fix ifdef (Alex)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Signed-off-by: Harry Wentland &lt;harry.wentland at amd.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Reviewed-by: Nicholas Kazlauskas &lt;nicholas.kazlauskas at amd.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Signed-off-by: Alex Deucher &lt;alexander.deucher at amd.com&gt;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; Cc: stable at vger.kernel.org</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; ---</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 ++++++++++--</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  1 file changed, 10 insertions(+), 2 deletions(-)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c index</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; 995f9df66142..bcb1a93c0b4c 100644</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; @@ -29,6 +29,7 @@</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  #include &quot;dm_services_types.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  #include &quot;dc.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  #include &quot;dc/inc/core_types.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +#include &quot;dal_asic_id.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  #include &quot;vid.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  #include &quot;amdgpu.h&quot;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; @@ -640,7 +641,7 @@ static void amdgpu_dm_fini(struct amdgpu_device</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; *adev)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  static int load_dmcu_fw(struct amdgpu_device *adev)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;  {</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; -       const char *fw_name_dmcu;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +       const char *fw_name_dmcu = NULL;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         int r;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         const struct dmcu_firmware_header_v1_0 *hdr;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; @@ -663,7 +664,14 @@ static int load_dmcu_fw(struct amdgpu_device</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; *adev)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         case CHIP_VEGA20:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;                 return 0;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         case CHIP_RAVEN:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; -               fw_name_dmcu = FIRMWARE_RAVEN_DMCU;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +#if defined(CONFIG_DRM_AMD_DC_DCN1_01)</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +               if (ASICREV_IS_PICASSO(adev-&gt;external_rev_id))</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +               else if (ASICREV_IS_RAVEN2(adev-&gt;external_rev_id))</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +                       fw_name_dmcu = FIRMWARE_RAVEN_DMCU;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +               else</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +#endif</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; +                       return 0;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;                 break;</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;         default:</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;                 DRM_ERROR(&quot;Unsupported ASIC type: 0x%X\n&quot;,</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt;                 adev-&gt;asic_type);</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; --</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; 2.20.1</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; </p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; _______________________________________________</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; amd-gfx mailing list</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; amd-gfx at lists.freedesktop.org</p>
<p style=" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; -qt-user-state:0;">&gt; &gt; &gt; &gt; &gt; https://lists.freedesktop.org/mailman/listinfo/amd-gfx</p></body></html>
--nextPart2424465.qbV5PHHhLX--




--===============0051126636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0051126636==--
