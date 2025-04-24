Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3B1C369D5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 07:39:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C81110E8AA;
	Fri, 25 Apr 2025 07:39:21 +0000 (UTC)
Received: from irl.hu (irl.hu [95.85.9.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED0BE10E0CF;
 Thu, 24 Apr 2025 09:06:42 +0000 (UTC)
Received: from [192.168.2.19] (51b69338.dsl.pool.telekom.hu
 [::ffff:81.182.147.56]) (AUTH: CRAM-MD5 soyer@irl.hu, )
 by irl.hu with ESMTPSA
 id 0000000000084239.000000006809FF1B.000C6449; Thu, 24 Apr 2025 11:06:34 +0200
Message-ID: <a2dbbf4e79c42b99d0772db5712f52a430864240.camel@irl.hu>
Subject: Re: amdgpu_dm_connector_mode_valid regression
From: Gergo Koteles <soyer@irl.hu>
To: Marek =?ISO-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Cc: Dmitry Baryshkov <dbaryshkov@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>, regressions@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Hans de Goede <hdegoede@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Date: Thu, 24 Apr 2025 11:06:34 +0200
In-Reply-To: <aAn6wsnJ-6mqK4vR@mail-itl>
References: <ed09edb167e74167a694f4854102a3de6d2f1433.camel@irl.hu>
 <8963a409dd575e040e5f07e4ad5e9c1d26b421f2.camel@irl.hu>
 <CALT56yPd-xfd=47xRxrCk4F3jib4Ti7kg8pRXy-gVAQpbOc=pw@mail.gmail.com>
 <e323219b52cda1891a55d12ad77a2b34edc8688b.camel@irl.hu>
 <Z_jodBrNFdEpJRKA@mail-itl> <aAn6wsnJ-6mqK4vR@mail-itl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 25 Apr 2025 07:39:20 +0000
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

Hi Marek,

On Thu, 2025-04-24 at 10:48 +0200, Marek Marczykowski-G=C3=B3recki wrote:
> On Fri, Apr 11, 2025 at 12:01:28PM +0200, Marek Marczykowski-G=C3=B3recki=
 wrote:
> >=20
> > Hi,
> >=20
> > On Wed, Apr 02, 2025 at 04:35:05PM +0200, Gergo Koteles wrote:
> > > Hi Dmitry,
> > >=20
> > > But the code would start to become quite untraceable.
> > > duplicate mode in amdgpu_dm_connector_mode_valid()
> > > call drm_mode_set_crtcinfo() in amdgpu_dm_connector_mode_valid()
> > > duplicate mode in create_stream_for_sink()
> > > overwrite ctrc in decide_crtc_timing_for_drm_display_mode()
> > > if crtc_clock =3D=3D 0 call drm_mode_set_crtcinfo() again in
> > > create_stream_for_sink()=20
> >=20
> > FWIW I'm affected by the same issue (on HP ProBook 445 G7, with AMD
> > Ryzen 5 4500U). And the patch quoted below fixes it for me too.
>=20
> I've re-tested it with 6.15-rc3 and the issue is still there. Is there
> something I can do to help fixing it before final 6.15 is out?
>=20

This patch has been accepted into the the amd drm-fixes-6.15 branch, so
hopefully it will be fixed in 6.15-rc4.

https://lore.kernel.org/dri-devel/24439c13a014e1cd200785db6f3dcf08f4773eb3.=
1743612701.git.soyer@irl.hu/
https://gitlab.freedesktop.org/agd5f/linux/-/commits/drm-fixes-6.15

Gergo

