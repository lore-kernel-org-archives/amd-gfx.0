Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0D8C44534
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jul 2026 07:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE95110E6E2;
	Tue, 21 Jul 2026 07:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="TfFOtuC6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5965110E194
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 13:14:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784553295; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FmTwSHj37zHybdIuT5hCZ0S8yqZYrQuuCR2srJjVgKXgAsuZZBx1OkOGNY9cNrrNkQ6355yv6bdI+GaOx0kO8cgcarLzniVSWF7GT9BbAoO2P65c1gvBOnsD+hK4F4KAwE+gMCm4Nbz8m6q9BdLfU8xlSaJqDO0LSpLWGMFiAeI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784553295;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=z2K795E7LOCbekohFidAHuNUmNq1tPbFUPm6zLYc/hs=; 
 b=MYghNghpAFWyZfY34k9vBGfe/zlmvB+n3TfYrg/RsDVmH6mP5GHBnNaTwM4SVGqB7Ser5FyqvbDLyf6DsTDmZXdkrJbk2NK5TgAAojXjvWe6ZRFyFVQLZ4tylw42EJmSFUfd74jCbM267Vi1VIS2L1yRavOOiZxzSYf/S8ACW1A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784553295; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
 bh=z2K795E7LOCbekohFidAHuNUmNq1tPbFUPm6zLYc/hs=;
 b=TfFOtuC6msu+cqkpgO3RND2kil6qGoHgkm/gqE6szuOzLxmipI6nPqPMmPLz/TSy
 6Qo87u3U+xxD9mKx5SeSJEJUImiUnQ7oUSG2TY6A7KrxtNUl8V9kxkHfHEDyKwJqu0f
 nl+25IUzBhUNS/iz6uRTWe+jr4CXo3f2RtPfLBlQ=
Received: by mx.zohomail.com with SMTPS id 1784553294231285.6527721727317;
 Mon, 20 Jul 2026 06:14:54 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: amd-gfx@lists.freedesktop.org, Chenyu Chen <chen-yu.chen@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 James Lin <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: Re: [PATCH 16/32] drm/amd/display: Add Support for HDMI Compliance
 Automation
Date: Mon, 20 Jul 2026 15:14:47 +0200
Message-ID: <dvZfompQRf-4fxleZDXPUg@collabora.com>
In-Reply-To: <nGLVvJOTS8eSI7IusBrUxw@collabora.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
 <20260610094639.1965367-17-chen-yu.chen@amd.com>
 <nGLVvJOTS8eSI7IusBrUxw@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Tue, 21 Jul 2026 07:22:12 +0000
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

On Wednesday, 10 June 2026 16:43:37 Central European Summer Time Nicolas Frattaroli wrote:
> On Wednesday, 10 June 2026 11:45:00 Central European Summer Time Chenyu Chen wrote:
> > From: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > 
> > Add support to get DUT trained at FRL link rate when working with
> > Teledyne M41h compliance automation.
> > 
> > Reviewed-by: Alex Hung <alex.hung@amd.com>
> > Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
> > Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> > ---
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +
> >  .../display/amdgpu_dm/amdgpu_dm_connector.c   |  5 ++
> >  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 67 ++++++++++++++++++-
> >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  6 ++
> >  4 files changed, 80 insertions(+), 1 deletion(-)
> > 
> > [... snip ...]
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
> > @@ -2982,6 +2982,64 @@ static ssize_t hdmi_cec_state_write(struct file *f, const char __user *buf,
> >  	return size;
> >  }
> >  
> > +/**
> > + * hdmi_automation_enable - Enable/Disable HDMI automation feature
> > + * @f: file structure.
> > + * @buf: userspace buffer. set to '1' to enable; '0' to disable automation feature.
> > + * @size: size of buffer from userpsace.
> > + * @pos: unused.
> > + *
> > + * Return size on success, error code on failure
> > + */
> > +static ssize_t hdmi_automation_enable(struct file *f, const char __user *buf,
> > +	size_t size, loff_t *pos)
> > +{
> > +	struct amdgpu_dm_connector *aconnector = file_inode(f)->i_private;
> > +	char *wr_buf = NULL;
> > +	const uint32_t wr_buf_size = 40;
> > +	int max_param_num = 1;
> > +	uint8_t param_nums = 0;
> > +	long param[2];
> > +	bool hdmi_comp_auto;
> > +
> > +	if (size == 0)
> > +		return -EINVAL;
> > +
> > +	wr_buf = kcalloc(wr_buf_size, sizeof(char), GFP_KERNEL);
> > +	if (!wr_buf)
> > +		return -ENOSPC;
> > +
> > +	if (parse_write_buffer_into_params(wr_buf, wr_buf_size,
> > +					   (long *)param, buf,
> > +					   max_param_num,
> > +					   &param_nums)) {
> > +		kfree(wr_buf);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (param_nums <= 0) {
> > +		kfree(wr_buf);
> > +		DRM_DEBUG_DRIVER("user data not be read\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (param[0]) {
> > +	case 0:
> > +		hdmi_comp_auto = false;
> > +		break;
> > +	case 1:
> > +	default:
> > +		hdmi_comp_auto = true;
> > +		break;
> > +	}
> > +
> > +	/* Persist setting across sink re-detection/hotplug. */
> > +	aconnector->hdmi_comp_auto = hdmi_comp_auto;
> > +
> > +	kfree(wr_buf);
> > +	return size;
> > +}
> > +
> >  DEFINE_SHOW_ATTRIBUTE(dp_dsc_fec_support);
> >  DEFINE_SHOW_ATTRIBUTE(dmub_fw_state);
> >  DEFINE_SHOW_ATTRIBUTE(dmub_tracebuffer);
> > @@ -3099,6 +3157,12 @@ static const struct file_operations dp_mst_link_settings_debugfs_fops = {
> >  	.llseek = default_llseek
> >  };
> >  
> > +static const struct file_operations hdmi_automation_debugfs_fops = {
> > +	.owner = THIS_MODULE,
> > +	.write = hdmi_automation_enable,
> > +	.llseek = default_llseek
> > +};
> > +
> 
> I really don't understand why this can't just be a DEFINE_DEBUGFS_ATTRIBUTE,
> and then you can replace the overcomplicated hdmi_automation_enable() with
> just simple setter and getter functions that already receive the parameter
> of the right type.

Aaaand this was applied without the review comment being addressed.

Along with the incredible other things in this series, like

   link.dpcd_caps.dongle_type = (typeof(link.dpcd_caps.dongle_type))0x7f;

in "[PATCH 21/32] drm/amd/display: Add KUnit tests for amdgpu_dm_connector",
I'm feeling like AMD is treating mainline as a vendor BSP to just dump code
into.

> >  static const struct {
> >  	char *name;
> >  	const struct file_operations *fops;
> > @@ -3131,7 +3195,8 @@ static const struct {
> >  	const struct file_operations *fops;
> >  } hdmi_debugfs_entries[] = {
> >  		{"hdcp_sink_capability", &hdcp_sink_capability_fops},
> > -		{"hdmi_cec_state", &hdmi_cec_state_fops}
> > +		{"hdmi_cec_state", &hdmi_cec_state_fops},
> > +		{"hdmi_automation", &hdmi_automation_debugfs_fops}
> >  };
> >  
> >  /*
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > index a2d0bb34e639..6350212b9a66 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> > @@ -193,6 +193,12 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
> >  					__func__, connector->name, edid_caps->frl_dsc_10bpc, edid_caps->frl_dsc_12bpc, \
> >  					edid_caps->frl_dsc_all_bpp, edid_caps->frl_dsc_native_420, edid_caps->frl_dsc_max_slices, \
> >  					edid_caps->frl_dsc_max_frl_rate, edid_caps->frl_dsc_total_chunk_kbytes);
> > +		if (aconnector->hdmi_comp_auto) {
> > +			edid_caps->panel_patch.hdmi_comp_auto = true;
> > +			link->ctx->dc->debug.force_frl_max = true;
> > +			link->ctx->dc->debug.force_frl_dsc = true;
> > +			drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] hdmi_comp_auto --> enabled\n", __func__, connector->name);
> > +		}
> >  	}
> >  
> >  	apply_edid_quirks(link, edid_buf, edid_caps);
> > 
> 
> 




