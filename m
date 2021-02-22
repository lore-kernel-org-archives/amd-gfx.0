Return-Path: <SRS0=DoF4=HY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA07CC433DB
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 23:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EDC064E05
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Feb 2021 23:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EDC064E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0567489F35;
	Mon, 22 Feb 2021 23:45:02 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF65A89F35;
 Mon, 22 Feb 2021 23:45:00 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 367AB64DA5;
 Mon, 22 Feb 2021 23:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614037499;
 bh=XFGxZWOiGtpFOFbxDLAcp9qcmWnZcBnW8fvwf4JwOUI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=AI2KKYoJMwsJst0ReZUzZzHJvM48mdR1eVEerDmFbIOQCx+Vo6tjOLhfZm7NvM5LQ
 wsjSN9gL29VPZ/SF5w5Sf80Ju31iF4opqVp82iRk0yE5lcdra2LeHGoQR0z7EkyKmo
 OxuDkq5+M1KIpouzLub8Aw2cCOloNG4onrTbhJ+0x5HnZOSxmovGpitjAVMLc3MmIq
 d9fcw0QkR5uom7qqUP1rEvV8JSYOXt6jBGGPDt39/oMRihD7c1XN2ocACIKm6Gbyyu
 g66hqnC778VmU6V24/M20sicvRno8QM3kXwtH0gkxC/Erwe0nie4mQ77JAd52k0nl3
 eSL/UHHUoL3cw==
Date: Mon, 22 Feb 2021 16:44:57 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH] drm/amdgpu/display: initialize the variable 'i'
Message-ID: <20210222234457.GA36153@24bbad8f3778>
References: <1614021931-4386-1-git-send-email-jrdr.linux@gmail.com>
 <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <32vjVDssCxltB75h5jHin2U3-cvNjmd_HFnRLiKohhbXkTfZea3hw2Knd80SgcHoyIFldMNwqh49t28hMBvta0HeWed1L0q_efLJ8QCgNw8=@emersion.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: stylon.wang@amd.com, sunpeng.li@amd.com, Bhawanpreet.Lakha@amd.com,
 dri-devel@lists.freedesktop.org, Rodrigo.Siqueira@amd.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 nicholas.kazlauskas@amd.com, airlied@linux.ie, aurabindo.pillai@amd.com,
 Souptick Joarder <jrdr.linux@gmail.com>, daniel@ffwll.ch,
 bas@basnieuwenhuizen.nl, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Feb 22, 2021 at 11:05:17PM +0000, Simon Ser wrote:
> On Monday, February 22nd, 2021 at 8:25 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
> > >> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9804:38:
> > >> warning: variable 'i' is uninitialized when used here
> > >> [-Wuninitialized]
> >                            timing  = &edid->detailed_timings[i];
> >                                                              ^
> >    drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:9714:7:
> > note: initialize the variable 'i' to silence this warning
> >            int i;
> >                 ^
> >                  = 0
> >    1 warning generated.
> >
> > Initialize the variable 'i'.
> 
> Hm, I see this variable already initialized in the loop:
> 
>     for (i = 0; i < 4; i++) {
> 
> This is the branch agd5f/drm-next.

That is in the

	if (amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
		|| amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_EDP) {

branch not the

	} else if (edid && amdgpu_dm_connector->dc_sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A) {

branch, where i is indeed used uninitialized like clang complains about.

I am not at all familiar with the code so I cannot say if this fix is
the proper one but it is definitely a legitimate issue.

Cheers,
Nathan

> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > index a22a53d..e96d3d9 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> > @@ -9717,7 +9717,7 @@ static bool parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> >  void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> >  					struct edid *edid)
> >  {
> > -	int i;
> > +	int i = 0;
> >  	struct detailed_timing *timing;
> >  	struct detailed_non_pixel *data;
> >  	struct detailed_data_monitor_range *range;
> > --
> > 1.9.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
