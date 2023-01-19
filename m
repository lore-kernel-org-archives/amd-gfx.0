Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA31C46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 19:11:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E508B10E20E;
	Thu, 19 Jan 2023 19:11:36 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA2B10E009
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 19:11:35 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 951FE61D41;
 Thu, 19 Jan 2023 19:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEC6C433F0;
 Thu, 19 Jan 2023 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674155493;
 bh=ZjNbyGBM5rvPBZfHtZF58SmnEhKMrrUo1Y+dRaj/GtQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EogRWFJ81Csgw6kXFN9uqzDwpcWeJ0jeCce0aog7NmHcMahAWhjipVKpXhV65Hvau
 7uPzNUS5qw98o5o6H/BHMM90ukojrJvqw/QlZmAq5RQo+Vt9/QnB6rBFXZ0GXN/pbH
 u+kwJ6D+1NFtfUjSs/qWbdqXH2R/FB5qZAvyV1NgjPLEOjnw34P14zR5CyU7tPkg9p
 VIoWhC2ZH4T2ssH3TJJ4BgrHdgqBgdawIeiUAHkAuV66R7BNPY6a4IbuBqLNgCJQB+
 lg8XhkoNjd5BI9vH9XwKm1v/t9NyfA+EUbXxHnzzOTAXTkKwntDg6PgUAfthP+sjot
 CotUALyJ9YyxQ==
Date: Thu, 19 Jan 2023 19:11:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 21/37] drm/amd/display: move dp capability related logic
 to link_dp_capability
Message-ID: <Y8mV3pCjYalwanIS@spud>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
 <20230110165535.3358492-22-Rodrigo.Siqueira@amd.com>
 <Y8kYKwU1Ky/b+3LW@wendy>
 <CADnq5_M2Q+Z9NHCksR10nummiX3zkakVnB+WHGV-UcK_OeP0YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zjdHo1uppBhB9IF8"
Content-Disposition: inline
In-Reply-To: <CADnq5_M2Q+Z9NHCksR10nummiX3zkakVnB+WHGV-UcK_OeP0YA@mail.gmail.com>
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
Cc: stylon.wang@amd.com, Wesley Chalmers <Wesley.Chalmers@amd.com>,
 Sunpeng.Li@amd.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 qingqing.zhuo@amd.com, wayne.lin@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, Bhawanpreet.Lakha@amd.com,
 solomon.chiu@amd.com, Conor Dooley <conor.dooley@microchip.com>,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, jerry.zuo@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


--zjdHo1uppBhB9IF8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 19, 2023 at 02:00:11PM -0500, Alex Deucher wrote:
> On Thu, Jan 19, 2023 at 1:55 PM Conor Dooley <conor.dooley@microchip.com> wrote:
> > On Tue, Jan 10, 2023 at 11:55:19AM -0500, Rodrigo Siqueira wrote:
> > > From: Wenjing Liu <wenjing.liu@amd.com>
> > >
> > > Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> > > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > > Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
> >
> > I haven't done a bisection, but I am getting build failures due to code
> > added by this patch (d5a43956b73bd in next-20230119) when running
> > allmodconfig for RISC-V with gcc-11.
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:21: error: 'union hdmi_encoded_link_bw' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> >
> >   233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
> >
> >       |                     ^~~~~~~~~~~~~~~~~~~~
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:42: error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type
> >
> >   233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
> >
> >       |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:231:17: error: function declaration isn't a prototype [-Werror=strict-prototypes]
> >
> >   231 | static uint32_t intersect_frl_link_bw_support(
> >
> >       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In function 'get_active_converter_info':
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76: error: storage size of 'hdmi_encoded_link_bw' isn't known
> >
> >  1125 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
> >
> >       |                                                                            ^~~~~~~~~~~~~~~~~~~~
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1129:101: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPPORT'
> >
> >  1129 |                                                                                 hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);
> >
> >       |                                                                                                     ^
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76: error: unused variable 'hdmi_encoded_link_bw' [-Werror=unused-variable]
> >
> >  1125 |                                                 union hdmi_encoded_link_bw hdmi_encoded_link_bw;
> >
> >       |                                                                            ^~~~~~~~~~~~~~~~~~~~
> >
> > cc1: all warnings being treated as errors

> Arnd already sent a patch to fix this. It should show up in my next
> drm-next update.

That's good to hear. I did a dfn:$filename search on lore and didn't see
anything other than this and:
https://lore.kernel.org/all/20230118093011.3796248-1-arnd@kernel.org/

I did some more looking and now see:
https://lore.kernel.org/all/20230118160722.289840-1-arnd@kernel.org/

Perhaps I should've expanded my initial search given it was a type
issue.

Thanks,
Conor.


--zjdHo1uppBhB9IF8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8mV3gAKCRB4tDGHoIJi
0jNeAQCYq/RxrZz4kRK/POC9uFD9qoKRMEUXhDkW7r2TlqvYvQD+Kj7SyCWlpOaT
qFJ/c8sj/byExHdfFi9My1cJ5fv0vgc=
=Nvht
-----END PGP SIGNATURE-----

--zjdHo1uppBhB9IF8--
