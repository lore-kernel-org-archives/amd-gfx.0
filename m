Return-Path: <SRS0=O5Im=PE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D5BC433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Oct 2021 10:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D1F960F9D
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Oct 2021 10:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8D1F960F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6509D6E42F;
	Sat, 16 Oct 2021 10:16:00 +0000 (UTC)
Received: from msg-4.mailo.com (ip-15.mailobj.net [213.182.54.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29F06E429;
 Sat, 16 Oct 2021 10:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1634379354; bh=zqWX1gJTKZ5q18uqa5c3Zf7qkP/A+CGNlGSRL6MHo7E=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=sMf3huKcgBE4f9Qx46mnqxxW0kG/4lohTFqKS0NtZxNeWRKEMyEaEtphj4CMJ+lgy
 /yujIldahtXxN2v73vppnv9iR+b7D3zue7w+NHiEgHvg8SjPPoR/slscBcmeAG2zbg
 QcfsijBw/h/KFQfk1ZZF+RMG9rE7rwfK3oj+PkBY=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Sat, 16 Oct 2021 12:15:54 +0200 (CEST)
X-EA-Auth: yKCNRkwyeIQN4zIZhVP/t5GZ4LXBCXpTe707pgk8CcqdT5Z8+L4zajcnVM6jjzg+UKc0YJNBMB/9WGFbSHtL4/w+9RPySOhn
Date: Sat, 16 Oct 2021 12:15:51 +0200
From: Claudio Suarez <cssk@net-c.es>
To: Harry Wentland <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Emma Anholt <emma@anholt.net>,
 Maxime Ripard <mripard@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Rob Clark <robdclark@gmail.com>,
 Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
 Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
 Neil Armstrong <narmstrong@baylibre.com>,
 Robert Foss <robert.foss@linaro.org>,
 Ben Skeggs <bskeggs@redhat.com>, nouveau@lists.freedesktop.org
Subject: Re: [PATCH 02/15] drm/amdgpu: use drm_* functions instead of
 duplicated code in amdgpu driver
Message-ID: <YWqmVwGQvosagb0s@gineta.localdomain>
References: <20211015113713.630119-1-cssk@net-c.es>
 <20211015113713.630119-3-cssk@net-c.es>
 <62a3ee8d-9439-9275-4e71-876b865b9a7d@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62a3ee8d-9439-9275-4e71-876b865b9a7d@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 15, 2021 at 11:14:54AM -0400, Harry Wentland wrote:
> 
> 
> On 2021-10-15 07:37, Claudio Suarez wrote:
> > a) Once EDID is parsed, the monitor HDMI support information is available
> > through drm_display_info.is_hdmi. The amdgpu driver still calls
> > drm_detect_hdmi_monitor() to retrieve the same information, which
> > is less efficient. Change to drm_display_info.is_hdmi
> > 
> > This is a TODO task in Documentation/gpu/todo.rst
> > 
> > b) drm_display_info is updated by drm_get_edid() or
> > drm_connector_update_edid_property(). In the amdgpu driver it is almost
> > always updated when the edid is read in amdgpu_connector_get_edid(),
> > but not always.  Change amdgpu_connector_get_edid() and
> > amdgpu_connector_free_edid() to keep drm_display_info updated. This allows a)
> > to work properly.
> > 
> > c) Use drm_edid_get_monitor_name() instead of duplicating the code that
> > parses the EDID in dm_helpers_parse_edid_caps()
> > 
> > Also, remove the unused "struct dc_context *ctx" parameter in
> > dm_helpers_parse_edid_caps()
> > 
> 
> Thanks for this work.
> 
> The fact that you listed three separate changes in this commit
> is a clear indication that this patch should be three separate
> patches instead. Separating the functional bits from the straight
> refactor will help with bisection if this leads to a regression.
> 
> All changes look reasonable to me, though. With this patch split
> into three patches in the sequence (b), (c), then (a) this is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Ok, thanks. I'll send three patches.

BR
Claudio Suarez



