Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C57C46467
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 18:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F0910E1CE;
	Thu, 19 Jan 2023 18:55:05 +0000 (UTC)
X-Greylist: delayed 424 seconds by postgrey-1.36 at gabe;
 Thu, 19 Jan 2023 10:22:55 UTC
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C256C10E8FE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1674123775; x=1705659775;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9SpgUN6Epamq9kQgLWOrW8GPg/nMI2a6MSPGYfaebCU=;
 b=Bar4e7l89uaY9L4k6a3bnuEA0M8rFi8ww3IeRHbUOUdRYUvG/2Fl4drt
 30sjznLNskyE7ZK8zqsnPIGa+3101YzOjZt82M+ulGH3en8Vjpb9d1f72
 aO3vZn6rrtXG3givvWnVtSCX0Of8tRMe6dMb/ABKplcr+OH4ds1d3Lc5W
 CPzKz4GETF9SobgANkhzjvIdTsyNZNhUePYbIsOOVu2AC8ORHsa0DeBNi
 P38PS7LPJZEWyYsM4FFyZ5tXZ1+iCmdCSqJ0kv65ZcTqjG06RJzkWTjRM
 Fc7CELN/wGMnXbl/DPwOcmNbG4V+WfiW/UmyiGFcniWBPMP6V+lWqOwaM w==;
X-IronPort-AV: E=Sophos;i="5.97,228,1669100400"; 
 d="asc'?scan'208";a="197275821"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 19 Jan 2023 03:15:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 19 Jan 2023 03:15:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16 via Frontend
 Transport; Thu, 19 Jan 2023 03:15:47 -0700
Date: Thu, 19 Jan 2023 10:15:07 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 21/37] drm/amd/display: move dp capability related logic
 to link_dp_capability
Message-ID: <Y8kYKwU1Ky/b+3LW@wendy>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
 <20230110165535.3358492-22-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/8hGrbCvyDXp0MQa"
Content-Disposition: inline
In-Reply-To: <20230110165535.3358492-22-Rodrigo.Siqueira@amd.com>
X-Mailman-Approved-At: Thu, 19 Jan 2023 18:55:04 +0000
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
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--/8hGrbCvyDXp0MQa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello!

On Tue, Jan 10, 2023 at 11:55:19AM -0500, Rodrigo Siqueira wrote:
> From: Wenjing Liu <wenjing.liu@amd.com>
>=20
> Reviewed-by: Wesley Chalmers <Wesley.Chalmers@amd.com>
> Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>

I haven't done a bisection, but I am getting build failures due to code
added by this patch (d5a43956b73bd in next-20230119) when running
allmodconfig for RISC-V with gcc-11.

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:21: =
error: 'union hdmi_encoded_link_bw' declared inside parameter list will not=
 be visible outside of this definition or declaration [-Werror]

  233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)

      |                     ^~~~~~~~~~~~~~~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:233:42: =
error: parameter 2 ('hdmi_encoded_link_bw') has incomplete type

  233 |         const union hdmi_encoded_link_bw hdmi_encoded_link_bw)

      |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:231:17: =
error: function declaration isn't a prototype [-Werror=3Dstrict-prototypes]

  231 | static uint32_t intersect_frl_link_bw_support(

      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c: In func=
tion 'get_active_converter_info':

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76:=
 error: storage size of 'hdmi_encoded_link_bw' isn't known

 1125 |                                                 union hdmi_encoded_=
link_bw hdmi_encoded_link_bw;

      |                                                                    =
        ^~~~~~~~~~~~~~~~~~~~

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1129:101=
: error: 'struct <anonymous>' has no member named 'MAX_ENCODED_LINK_BW_SUPP=
ORT'

 1129 |                                                                    =
             hdmi_color_caps.bits.MAX_ENCODED_LINK_BW_SUPPORT);

      |                                                                    =
                                 ^

drivers/gpu/drm/amd/amdgpu/../display/dc/link/link_dp_capability.c:1125:76:=
 error: unused variable 'hdmi_encoded_link_bw' [-Werror=3Dunused-variable]

 1125 |                                                 union hdmi_encoded_=
link_bw hdmi_encoded_link_bw;

      |                                                                    =
        ^~~~~~~~~~~~~~~~~~~~

cc1: all warnings being treated as errors

Thanks,
Conor.


--/8hGrbCvyDXp0MQa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY8kYHQAKCRB4tDGHoIJi
0pbuAP9U46LchotTugWM4ZsYuQQhqlxCW41en+SPyBhSnYfz6QD/ac+CuigXZbnm
xudNdcMAyo2zRL/pE3aiybQkfmffXgQ=
=/L4Z
-----END PGP SIGNATURE-----

--/8hGrbCvyDXp0MQa--
