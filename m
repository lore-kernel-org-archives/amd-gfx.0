Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C893C05027
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Jan 2023 23:15:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110AC10E3BA;
	Fri, 20 Jan 2023 23:15:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D93210E3B9
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 23:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674256505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XoknDUURrHLa74EzxLJ8GYuKHj7PHhY7S/GVYWdBSwk=;
 b=EwRdcSrnTNRQraJwNwT3RZHTtBGvrYhgC/C1SFawqk9PAJC89oZnivFuSxD/2NZMpmh1fH
 UTPceuWo3R86hkoWpevIiptmu59zNVF01oQkvtqI2B0om+HyZUC7Mqph8fcpz6JCbay+c9
 2HXLy8QmG6uiDUBdYsPY4ibnTH2YBuI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-255-nkBzyt68MriodP-eA-FBpQ-1; Fri, 20 Jan 2023 18:15:04 -0500
X-MC-Unique: nkBzyt68MriodP-eA-FBpQ-1
Received: by mail-qt1-f200.google.com with SMTP id
 q26-20020ac8735a000000b003b63165d87cso3097138qtp.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Jan 2023 15:15:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=mime-version:user-agent:content-transfer-encoding:organization
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XoknDUURrHLa74EzxLJ8GYuKHj7PHhY7S/GVYWdBSwk=;
 b=ew/B988U+S0dkmfJnlNmuWw4VkXSm9SEs8pogeTjIwEWYweeWRdHUObebxMKR//euC
 W81onNhsUVdVIOpAC7TWwJVrMYlPZDPU5YPDLKmYeajRuYR5Y40BFRdRCdkK/dqipf6x
 y6+3g2pmC6LTyCR+4fO1Q8qIeXaohzQ/13bPPawa9lcyDBGcIryRqKHXNoy2VnzXBg8r
 qjvvTCrAXVN2VV4HxAnUzxdl//kJ4hnkHPbYHLlV5SD47RCZsW+EkXRmX9M07nK4VcUc
 jm7TwPQC7FX79OJjllkkuRSHEYj0GewBIhAvxhgWQDI19zzEUoJSJLRkV94Y1nVsytMR
 UIjw==
X-Gm-Message-State: AFqh2kr4nUcJH6UjnnMBgZ/v2WMOz2LRISkNudIaMObCkpQZL/+rB7zw
 h6WO4un4MNTwusnBznaoNECLb/0ouwBsLpbDAqzS9SCOP4GjnI2vd+l6OcQgugLvDalO8wcqSwq
 tkdD3TQCTJh2rgkeTuLJVpKd+uQ==
X-Received: by 2002:ac8:4a9a:0:b0:3a7:e727:a015 with SMTP id
 l26-20020ac84a9a000000b003a7e727a015mr23249545qtq.20.1674256503676; 
 Fri, 20 Jan 2023 15:15:03 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuZ3OPhHyBXwLeLq03lJ8ap+cBCoJRfLsiSu+d4wxp73Gisjo99Hu0iq4zK0iczrQyF7CosDA==
X-Received: by 2002:ac8:4a9a:0:b0:3a7:e727:a015 with SMTP id
 l26-20020ac84a9a000000b003a7e727a015mr23249517qtq.20.1674256503430; 
 Fri, 20 Jan 2023 15:15:03 -0800 (PST)
Received: from ?IPv6:2607:fb91:2d97:94eb:ed0e:2784:4519:138f?
 ([2607:fb91:2d97:94eb:ed0e:2784:4519:138f])
 by smtp.gmail.com with ESMTPSA id
 c4-20020a05620a268400b006fefa5f7fcesm22371923qkp.10.2023.01.20.15.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Jan 2023 15:15:02 -0800 (PST)
Message-ID: <965500917008cd17b47c1be1f5eeda7ccc4eede6.camel@redhat.com>
Subject: Re: [PATCH 0/7] Fix MST on amdgpu
From: Lyude Paul <lyude@redhat.com>
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Date: Fri, 20 Jan 2023 18:15:00 -0500
In-Reply-To: <20230119235200.441386-1-harry.wentland@amd.com>
References: <20230119235200.441386-1-harry.wentland@amd.com>
Organization: Red Hat Inc.
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: stable@vger.kernel.org, stanislav.lisovskiy@intel.com, jerry.zuo@amd.com,
 bskeggs@redhat.com, Wayne.Lin@amd.com, ville.syrjala@linux.intel.com,
 mario.limonciello@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

For the whole series:

Reviewed-by: Lyude Paul <lyude@redhat.com>

So glad to have this fixed finally =E2=99=A5

On Thu, 2023-01-19 at 18:51 -0500, Harry Wentland wrote:
> MST has been broken on amdgpu after a refactor in drm_dp_mst
> code that was aligning drm_dp_mst more closely with the atomic
> model.
>=20
> The gitlab issue: https://gitlab.freedesktop.org/drm/amd/-/issues/2171
>=20
> This series fixes it.
>=20
> It can be found at
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/mst_regression
>=20
> A stable-6.1.y rebase can be found at
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/mst_regression_6.1
>=20
> Lyude Paul (1):
>   drm/amdgpu/display/mst: Fix mst_state->pbn_div and slot count
>     assignments
>=20
> Wayne Lin (6):
>   drm/amdgpu/display/mst: limit payload to be updated one by one
>   drm/amdgpu/display/mst: update mst_mgr relevant variable when long HPD
>   drm/drm_print: correct format problem
>   drm/display/dp_mst: Correct the kref of port.
>   drm/amdgpu/display/mst: adjust the naming of mst_port and port of
>     aconnector
>   drm/amdgpu/display/mst: adjust the logic in 2nd phase of updating
>     payload
>=20
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  4 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 48 +++++++++---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 16 ++--
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 76 +++++++++++++------
>  .../display/amdgpu_dm/amdgpu_dm_mst_types.c   | 53 ++++++-------
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 14 +++-
>  drivers/gpu/drm/display/drm_dp_mst_topology.c |  4 +-
>  include/drm/drm_print.h                       |  2 +-
>  10 files changed, 143 insertions(+), 80 deletions(-)
>=20
> --
> 2.39.0
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

