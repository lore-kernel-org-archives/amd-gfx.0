Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7C07C5DF89
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 19:35:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4038D10F17F;
	Thu, 20 Aug 2026 19:35:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8RENewc";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B331510F17F
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 19:35:35 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca53979f8e8so31968a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 12:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787254535; cv=none;
 d=google.com; s=arc-20260327;
 b=R7bvNrLAFKTc0kb4KD/6zSsGIHbHcdIKcBD5+Of0pzUAx5hCUIW596gbUWadeA9Wil
 IEuIhT2WR9KLAQMM9czEjefLQ4s4q784Ts5aZF3K3rBuxkFrVIEr0rbzZazBweY0UR7a
 dy9FwLaVCybx13NPDeL2AHbu4MWKpQ0KhPCTkKcmX2lSyW87NOIsQFn7HUrGb+Mph2lK
 CMcteQ4vX6UBL9M4s+nlnGiVXOXERlZlUWWMCDXoD2JHgk++LvyD2Mmc2BakRfc7OMEw
 5K3Kcxmixb3wi+lKBiorWRZkuyIFPyqb+v+2OprMeNPlST6NZkRfAngK8Ughf5SByXzi
 xtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 fh=CBsscPxRx0t1IZlgmntxn+VAQlWh6r2bS0v24EukBWE=;
 b=kyFonQFq1kS9EGvVPh+nnAUgMGME17vhDwA+f4cOd0KaGds60KHu0iWLOmwHTM/3Qb
 Sb/BE3+gxmM5xgc7jnS/npZx0Da80Dglf+NHPOC5v+rPRLPsE0dZz2yPthelQGRajAmz
 b94osdZRZiZsR90J2px3KoR9qrpn4iHo4J3S2/dTujhbol/KPFagDu4gVscx2IN3Dngx
 He1akRVVwlaAwK60E9oQH1cSzQVJGrd1aIq7pextJPhO26KLm5vMjlkFFPlzKHZ8d+Vh
 LyU5eFxTokHel5DEZEo/VVnTuRK0Fj6fnRD3zcqLm7SMjF1pdQjrqVViyLXjnsJObmCw
 VgFw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787254535; x=1787859335; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 b=h8RENewcf4Hc6WiVMeCucYhLVj5uwGpTqd22bQ4KHmH52we8RYPTGwda4wjq/IUL1Z
 qLv0oDTqllAwF85xAjUUadFxqHD+Nd4ZgZWkVthGayvw3gBbEMkzGl6rTcwWP8azYLWV
 gIPO5XDaK8WM2cZ9Y2T2zS5JuNXAoqV4TV9DN1LDt1GKc+YX3ADWibCzm0AEdzGBkPXT
 AAkjpPALoOXv0ZRq93AJPK7YQSRYo5NWHGKWGJCWsIRnVm7zp8BjlWqS0dsC8BMR7+aD
 KcAzfw1asTVoI2wFMI9Fip7o5zYm9fkSnoLrSotf8JbclDer4ozYJ5eugbiytIWl5ivV
 4SAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787254535; x=1787859335;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gqytTIc7u2uOtpbZfg574tdAzUb/kPMViOM7fTVII1Y=;
 b=UMvZvk+iDoxGNBeLOwu0QVFcLMtjOqOrqcwYKpVCnjzqCDIwE9xlS5Nt3uQpDWxOCh
 MGJYal660C+j2OfUba4bFa4lVVW9V37lrmho1QfWE3pfcsNa74ewF02jSW849DfQeqnr
 oXqyZkkr0P2DJiekaxnio7r21X1W22Kxnif4JpPaI//wN+URg/zjghg15AEOQvwtmRnm
 6AVQjwZux3jovuqdw9IzuxbgTMBL+xb9z5/uyxF4WZlet9Dinw1VFkdrP58rkbzPa9t0
 T8cMqnwgBwucV54Ahlf/Zn25jlT/FFbuzqLpdgEeNDsenhPSUwxdjd+TBLSuSzSDansm
 VYjw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqO7tob8qYTgSeKkCmax7/6wsOPGbRUbppqsZLz+8n0iinGOB+ddXPYtpBQP1DLk+Kod2PdnGwa@lists.freedesktop.org
X-Gm-Message-State: AFuF++kV6vl06D0uYL+fASiwoHpBcJnSVWMqd7C1Zz93mFc2eHXaMgFW
 a2M3oUkRcSFUq/gT6cYsTSBpkVeYdgxjKfBcyU1xzVlHFiTTWQIJ7sKUYhhrKoKxMBhB2N2wqbj
 IdNKREYmxQ+MAoIpt/QQuLhwQ6CjIhNk=
X-Gm-Gg: AR+sD11Sr8NFhKdfMEsh/xNLIOb3w6Y2hu0qX5F2zR/jZS/UdOqN1tR7/0Nd+AZKFZU
 ytx4ELHIqR5oWb5KUimT78R72VTTXvQJyNkxVV3yetUBR1RZ3sIlQghB62pmeC6321U/2OOgNuW
 Ekkcyej68Lvl8urNVNn0txSWhQXFGYYMBZy9ZqDfYiqiFBValAnbLkhPT9UaRb9EaA369nfOG9q
 KGCdaEEQGCRctMm3QiNPvwb/G0tpu6ZqvVw3NJoTSi46Q9+e4W65ilUgxCQPunGDaUgdTvVs2K6
 BD117jf/niLIMGUc8/39IJtyZCAcT5igRtYEaSM7D20OAd3Ei+3nJG+R2coRKhDWYgJsay9TUrz
 xtyaFV31jo2ku+vD5o4mUoWCwPTNl454=
X-Received: by 2002:a17:90b:1b03:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-395c35d68demr662214a91.4.1787254535103; Thu, 20 Aug 2026
 12:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260820142802.1342066-2-rodrigo.vivi@intel.com>
 <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
In-Reply-To: <e48a854b-1240-4fcb-a429-2c02be10da5d@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 15:35:23 -0400
X-Gm-Features: AcwNN1UwFcHSw7D74U3tBOLcfnE6T2qJeXaLFCpWNAHVx_ZWYlTuFww1BcGCv8I
Message-ID: <CADnq5_PvMKVbmukOJW9oHK-bw3110eAf97WXfUVi-urhcEGMMg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Drop KUnit tests for removed
 parse_hdmi_amd_vsdb()
To: Mario Limonciello <superm1@kernel.org>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Alex Huang <Alex.Huang2@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Aug 20, 2026 at 3:30=E2=80=AFPM Mario Limonciello <superm1@kernel.o=
rg> wrote:
>
> On 8/20/26 09:28, Rodrigo Vivi wrote:
> > parse_hdmi_amd_vsdb() was removed when HDMI FreeSync detection moved to
> > the common EDID parser, but its declaration and KUnit tests remained,
> > breaking modpost:
> >
> >    ERROR: modpost: "parse_hdmi_amd_vsdb" [...connector_test.ko] undefin=
ed!
> >
> > Remove the stale declaration and the three dead test cases.
> >
> > Fixes: f65198b3d073 ("drm/amd/display: Use HDMI FreeSync range from com=
mon EDID parser")
> > Cc: Alex Huang <Alex.Huang2@amd.com>
> > Cc: Mario Limonciello <superm1@kernel.org>
> > Assisted-by: Copilot:Claude-Opus-5
> > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > ---
> Thanks this looks correct to me.
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
> I'm not sure where we should apply it though, it's from a conflict
> between drm-misc-next and Alex's drm-next pull.

I'll pull it into my next -fixes PR.

Alex

> >   .../display/amdgpu_dm/amdgpu_dm_connector.h   |  3 -
> >   .../tests/amdgpu_dm_connector_test.c          | 73 ------------------=
-
> >   2 files changed, 76 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.=
h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > index 4e9eb3ff2c90..ce900844602e 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
> > @@ -153,9 +153,6 @@ void parse_edid_displayid_vrr(struct drm_connector =
*connector,
> >                             const struct edid *edid);
> >   int get_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> >                struct amdgpu_hdmi_vsdb_info *vsdb_info);
> > -int parse_hdmi_amd_vsdb(struct amdgpu_dm_connector *aconnector,
> > -                     const struct edid *edid,
> > -                     struct amdgpu_hdmi_vsdb_info *vsdb_info);
> >   void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)=
;
> >   enum dc_status dm_validate_stream_and_context(struct dc *dc,
> >                                             struct dc_stream_state *str=
eam);
> > diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_conn=
ector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connec=
tor_test.c
> > index a54fd9529dc9..83d3be543202 100644
> > --- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_t=
est.c
> > +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_t=
est.c
> > @@ -4874,75 +4874,6 @@ static void dm_test_get_amd_vsdb_supported(struc=
t kunit *test)
> >       KUNIT_EXPECT_TRUE(test, vsdb_info.replay_mode);
> >   }
> >
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_null_edid - Test NULL EDID returns -ENO=
DEV
> > - * @test: The KUnit test context
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_null_edid(struct kunit *test)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, NULL, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_no_extensions - Test EDID without exten=
sions
> > - * @test: The KUnit test context
> > - *
> > - * An EDID that declares no extension blocks has no CEA block to parse=
.
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_no_extensions(struct kunit *te=
st)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -     struct edid *edid;
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -     edid =3D kunit_kzalloc(test, sizeof(*edid), GFP_KERNEL);
> > -     KUNIT_ASSERT_NOT_NULL(test, edid);
> > -
> > -     edid->extensions =3D 0;
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> > -/**
> > - * dm_test_parse_hdmi_amd_vsdb_no_cea_ext - Test EDID with no CEA exte=
nsion
> > - * @test: The KUnit test context
> > - *
> > - * An extension block that is not a CEA block leaves no VSDB to parse.
> > - */
> > -static void dm_test_parse_hdmi_amd_vsdb_no_cea_ext(struct kunit *test)
> > -{
> > -     struct amdgpu_dm_connector *aconnector;
> > -     struct amdgpu_hdmi_vsdb_info vsdb_info =3D {0};
> > -     struct edid *edid;
> > -     u8 *raw;
> > -
> > -     aconnector =3D kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNE=
L);
> > -     KUNIT_ASSERT_NOT_NULL(test, aconnector);
> > -
> > -     /* Base block + one extension block that is NOT a CEA extension. =
*/
> > -     raw =3D kunit_kzalloc(test, 2 * EDID_LENGTH, GFP_KERNEL);
> > -     KUNIT_ASSERT_NOT_NULL(test, raw);
> > -     edid =3D (struct edid *)raw;
> > -     edid->extensions =3D 1;
> > -     raw[EDID_LENGTH] =3D DM_TEST_DISPLAYID_EXT;
> > -
> > -     KUNIT_EXPECT_EQ(test,
> > -                     parse_hdmi_amd_vsdb(aconnector, edid, &vsdb_info)=
,
> > -                     -ENODEV);
> > -}
> > -
> >   /**
> >    * dm_test_parse_displayid_vrr_null_edid - Test NULL EDID leaves rang=
e untouched
> >    * @test: The KUnit test context
> > @@ -5647,10 +5578,6 @@ static struct kunit_case amdgpu_dm_connector_tes=
ts[] =3D {
> >       /* get_amd_vsdb */
> >       KUNIT_CASE(dm_test_get_amd_vsdb_unsupported),
> >       KUNIT_CASE(dm_test_get_amd_vsdb_supported),
> > -     /* parse_hdmi_amd_vsdb */
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_null_edid),
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_extensions),
> > -     KUNIT_CASE(dm_test_parse_hdmi_amd_vsdb_no_cea_ext),
> >       /* parse_edid_displayid_vrr */
> >       KUNIT_CASE(dm_test_parse_displayid_vrr_null_edid),
> >       KUNIT_CASE(dm_test_parse_displayid_vrr_no_displayid),
>
