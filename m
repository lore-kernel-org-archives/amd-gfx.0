From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: drm/amd/display: Add HDCP module - static analysis bug report
Date: Wed, 9 Oct 2019 20:43:58 +0200
Message-ID: <CAKMK7uEtJRDhibWDv2TB2WrFzFooMWPSbveDD2N-rudAwvzVFA@mail.gmail.com>
References: <951eb7dc-bebe-5049-4998-f199e18b0bf3@canonical.com>
 <20191009163235.GT16989@phenom.ffwll.local> <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0d5f3a3-a2b3-5367-42f9-bde514571e25@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Cc: Colin Ian King <colin.king@canonical.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx mailing list <amd-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 9, 2019 at 8:23 PM Lakha, Bhawanpreet
<Bhawanpreet.Lakha@amd.com> wrote:
>
> Hi,
>
> The reason we don't use drm_hdcp is because our policy is to do hdcp
> verification using PSP/HW (onboard secure processor).

i915 also uses hw to auth, we still use the parts from drm_hdcp ...
Did you actually look at what's in there? It's essentially just shared
defines and data structures from the standard, plus a few minimal
helpers to en/decode some bits. Just from a quick read the entire
patch very much looks like midlayer everywhere design that we
discussed back when DC landed ...
-Daniel

>
> Bhawan
>
> On 2019-10-09 12:32 p.m., Daniel Vetter wrote:
> > On Thu, Oct 03, 2019 at 11:08:03PM +0100, Colin Ian King wrote:
> >> Hi,
> >>
> >> Static analysis with Coverity has detected a potential issue with
> >> function validate_bksv in
> >> drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c with recent
> >> commit:
> >>
> >> commit ed9d8e2bcb003ec94658cafe9b1bb3960e2139ec
> >> Author: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> >> Date:   Tue Aug 6 17:52:01 2019 -0400
> >>
> >>      drm/amd/display: Add HDCP module
> > I think the real question here is ... why is this not using drm_hdcp?
> > -Daniel
> >
> >>
> >> The analysis is as follows:
> >>
> >>   28 static inline enum mod_hdcp_status validate_bksv(struct mod_hdcp *hdcp)
> >>   29 {
> >>
> >> CID 89852 (#1 of 1): Out-of-bounds read (OVERRUN)
> >>
> >> 1. overrun-local:
> >> Overrunning array of 5 bytes at byte offset 7 by dereferencing pointer
> >> (uint64_t *)hdcp->auth.msg.hdcp1.bksv.
> >>
> >>   30        uint64_t n = *(uint64_t *)hdcp->auth.msg.hdcp1.bksv;
> >>   31        uint8_t count = 0;
> >>   32
> >>   33        while (n) {
> >>   34                count++;
> >>   35                n &= (n - 1);
> >>   36        }
> >>
> >> hdcp->auth.msg.hdcp1.bksv is an array of 5 uint8_t as defined in
> >> drivers/gpu/drm/amd/display/modules/hdcp/hdcp.h as follows:
> >>
> >> struct mod_hdcp_message_hdcp1 {
> >>          uint8_t         an[8];
> >>          uint8_t         aksv[5];
> >>          uint8_t         ainfo;
> >>          uint8_t         bksv[5];
> >>          uint16_t        r0p;
> >>          uint8_t         bcaps;
> >>          uint16_t        bstatus;
> >>          uint8_t         ksvlist[635];
> >>          uint16_t        ksvlist_size;
> >>          uint8_t         vp[20];
> >>
> >>          uint16_t        binfo_dp;
> >> };
> >>
> >> variable n is going to contain the contains of r0p and bcaps. I'm not
> >> sure if that is intentional. If not, then the count is going to be
> >> incorrect if these are non-zero.
> >>
> >> Colin
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
