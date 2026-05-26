Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CECACD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 13:55:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43A010E1AA;
	Tue, 26 May 2026 13:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="KHxlsAYS";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF53D10E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 13:55:14 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gPvQR2Zjcz9tLy;
 Tue, 26 May 2026 15:55:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1779803711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6T1/3aYc4ycWTfDxsQYfOfVw8/7TzeOfVRCGfOaMWeU=;
 b=KHxlsAYS2z+rjpqX12o2219lC1Uu3S3OwYvc4L2LSr/AqJgvj3RFsHdSMWhlV7sqSA36zJ
 tp4p8ahU80oVJTsMU6XSYmBMVuGCuh5LrZytD8XZNGFC02F/FPzhbx8p34vgt2BT0ot/VF
 CwiNmlnKZED7sKaaspCqgvc78jF3TJK7F+43464mcYCAjn90yVEs2AZCrvXkDKg6QEM2ZG
 Yv7IB8qLw93vbTql/b1uc3pPVUeBSiVRgfVG1bNhk3iMRRsL9XlqUtUqFEEH6rfgTU5AVo
 CfJG/CatzdfNVBEVzUGE3Y0TQXuCI9eh2aWqSmDtgNKJDVf2mNYl/ZiSHNPcpg==
Message-ID: <1fb98dd3-55fd-4269-91bd-292b1167718b@mailbox.org>
Date: Tue, 26 May 2026 15:55:07 +0200
MIME-Version: 1.0
Subject: Re: [External Mail] Re: Test result / finding of "drm/amd/display:
 Consult MCCS FreeSync cap only if requested & supported"
To: Pei-Hsin Yang <peihsiny@valvesoftware.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <44069eb146824aa195312f5b02c49287@valvesoftware.com>
 <7a9021cd-fd78-4b0d-846b-135d0d72224e@mailbox.org>
 <16231b1742004f848af243ce398281ec@valvesoftware.com>
 <ce51243c-3b98-4f99-911f-70dd0b860da0@mailbox.org>
 <431e78bafdc7402398d5b7bc85d81252@valvesoftware.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <431e78bafdc7402398d5b7bc85d81252@valvesoftware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jp3ewptshsyz8knur7g57jaf4xmqhu17
X-MBO-RS-ID: e7619f88b30a63144c8
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

On 5/23/26 00:15, Pei-Hsin Yang wrote:
>> Note that some kind of short-term solution is needed for the regression(s) in 7.1-rc.
> 
> Here is my suggestion as a short-term workaround:  
> 	- Just refer to the vsdb_info data structure to set the value of freesync_capable.  freesync_mccs_vcp_code = 0 doesn't mean FreeSync is not supported.
> 	- Check both freesync_supported and freesync_mccs_vcp_code along with do_mccs to call dm_helpers_mccs_vcp_set().
> 	- Note that MCCS command over DDC might be failed at runtime, but at least, it will not inadvertently disable the VRR if (1) sink is FreeSync supported but vcp_code = 0, or (2) dm_helpers_read_mccs_cap() failed intermittently at runtime.
> 
> Patch created based on commit 53f0235c0284fc676d1510a460e1c6c111de3ea1 is attached as a reference for AMD team to review.
> 
> commit 53f0235c0284fc676d1510a460e1c6c111de3ea1 (HEAD -> amd-staging-drm-next, origin/amd-staging-drm-next, origin/HEAD)

In the future, please send patches inline, to make giving feedback easier.


> @@ -13680,11 +13680,10 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
> 
>         if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
>                 as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
> -               (!sink->edid_caps.freesync_vcp_code ||
> -               (sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
> +               (!vsdb_info.freesync_supported))
>                 freesync_capable = false;

vsdb_info.freesync_supported already guards setting freesync_capable = true in the first place (given either of the other two conditions) above, so this if-statement looks superfluous now.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
