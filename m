Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D6DE81A2D
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Feb 2026 14:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94AB310E138;
	Mon, 16 Feb 2026 14:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JZE7SvUO";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAAC610E138
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 14:41:56 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1273882d901so138237c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Feb 2026 06:41:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771252916; cv=none;
 d=google.com; s=arc-20240605;
 b=XSf851wnKfftzZWJfqCUC6KJSlC149qgA1CYYP4tWWXHyEcAWVhj9nmYUZPuUPymDd
 oyW61xf6zkhVkMS/0iCYT50SI9lWA/aHb0Clf2N4It/esqnvJC29PLkaB0NwPATEmk48
 ZMzB4xX19bwGhQgE6ptqScC27o1fJhKWb7M1P8eYgLwe+ipqTtGvSPz+1j5ftrIYgGED
 OXrBSWoK27jcDy3GMw0q9WOjtvalVCt8k1/05VfOZBEC9YxbskCMv18yaTK7X2Utz84I
 7jedI3K7htDB1BOJkz4dD0mk1rQURZhDzYlCJIsUu7/PSWNHt7wZvl3C8SK4CYTxXFRr
 tnMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DNUkFbvtGA1YtlsSQPkW9Wr+N44A6mVFdi+7lI+azjc=;
 fh=ZigtSWacc/PY/DhU6+Gejcggoc6ivqtIYvsOLa9mho8=;
 b=bM6bngocPyzS8CGrrFqLQq4rvHmOnRFvDlv/aRF2GrC4ypCsU6ZJVvX7XALJ4faBLD
 FOJ9RWXfO7i1WDh7QjvgA+hP+9gXRdb/yJtnEXktSS9XUVD3fwsfDKYomVxO8qX6B9rw
 qj477vd5MFpkvNkpIlwvj4aZjbVqTU/HEamarwICi+DP/0Ma0tqPv24jqv8JhJG3mHVG
 K/epKrt63QWiRsRD5/FRRp/RqQYGrrVcy1DsHRuVJjmA//oLQC7m3Wy+mbnJqbv9+LB7
 FChVAs3yIM6ZBMFUuW+K7bgrsfETEd26Pi2qL1ahOM1wHRVtvSsKPoO/ENE7IBdRsb5y
 O7AQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771252916; x=1771857716; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNUkFbvtGA1YtlsSQPkW9Wr+N44A6mVFdi+7lI+azjc=;
 b=JZE7SvUOGOu4v6yoKwj1sMbIqSJBWhxZo5khV3nWkyvXtFR0c8Zx8KPQ3roTnazI8T
 yMuecIBIxb0iOkvE1Q0OxfCt3sWbWfnA8DAkQGd3rTcEyiJn2U/ty+PplAvOZ0tG0qAE
 W3heDo42A/qdfURyw1WuQtoAH/SdXVHzHp6tGrsremv6OJMrzVidLoatIhF/CeGQHNMD
 jaQzjmBfYZif3zpF03JHQsrGULjLIdBdAtsXjaMpH9xbo8xU+GWz9PXF63p+ibUjBZU1
 +p4BuL2b/Zu95I7KKZSdOO2fMZUG80bO/o1djwJsUVN6snALEIQ4dA8WlTje627zuV5S
 NXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771252916; x=1771857716;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DNUkFbvtGA1YtlsSQPkW9Wr+N44A6mVFdi+7lI+azjc=;
 b=ATDlUxi7RXjeRF4bXGvzaGNg40G6NhtbWmUTu4a1gKOdQWO2V+MXUfp6NQmmZVLMm9
 u82sM8SxEr0RaZEqKrNaS2xlZGcw6e2LDanHclpHCl5Ik8QjUNrsAWqLolZrBpyJvw/I
 3Yag51jtxErx80hoMkOWfjpsDq6adUkmTNOhx+IQwvp1UPlsTEXm9FLWSnhpcmMdbXZl
 UDy7P+Yh1hBiyp2z97pFikCa9TEELjfCAY+2mVXR9Y/BQ2NUsGEvONMaOW5llcBZrk9w
 e2q4W3vapGIJs++eGEzKt8OkVkLbXVR3P9GoEHQhfeZ64pgMXaS1OXOeFr32GtZpWDPm
 DOHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9PhgKc80VZjNqJQ3DLAnrc++cWn7enn2E+9caZUG5axfCDSXIXeu2SOOUR/gYP0gQnvOaPbFq@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLVYUbI/iWYwnrtvypC8uwqSsS9Q1c6anzK0aTEuJtV5swzWk3
 c5UdxtX7F3XVWPE44Q8hnKlAI3fW09UFuHYl13N3hLSO73xqpU7UR6K9Cyqkj0mh4P5qe3ZlBkx
 FcC497cQVN4FCO9CuGpNDaH++F4TEgJE=
X-Gm-Gg: AZuq6aIiJTCp5ZV+oGUV5jzRT41ac58H+7c1plb7VRN3KJD+jbPaXhYyZY7XqVSIBf/
 vJkkALNhcMSw7/foPStg0cjnlvCjX1wOeH0AQHqTlYkxxY+ONsNCWWUHmrlv/Mhi+qYGtf/Hc9o
 keawaOV/xvlKMxmgsvh1wN5L8mo0UbGgvzsEzIrRt/BjFV07S5asTpmy6GPFUCwbGeB6+AdPuVg
 iIu2xxuA0m56vwPjpWDkNY3NWVGSdYuD5AmIHtdt8GSO9lJE5ynIWgFiXsi/DXSxB1/fYuH+Eie
 0CJciwpFpQtUomq48gQmTRG1zgXt+1YGl+aMJ+ezA/UO81ZMK0WGSdd0bM29D+lPZNkUQQ==
X-Received: by 2002:a05:7022:1282:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-127396b870dmr2210698c88.0.1771252915786; Mon, 16 Feb 2026
 06:41:55 -0800 (PST)
MIME-Version: 1.0
References: <20260202112508.43000-1-timur.kristof@gmail.com>
 <CADnq5_OKvYO6ibNLmzuK3tW_sEaaCB82FgoLUc+NPb2asuck=w@mail.gmail.com>
 <cf272efe-c0d4-47f2-a62b-7e47973632dc@amd.com>
In-Reply-To: <cf272efe-c0d4-47f2-a62b-7e47973632dc@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Feb 2026 09:41:44 -0500
X-Gm-Features: AaiRm52EF1i14mAfJajBVb6gXu9FMKQYwx21USzL2FLzYfj2yFxbTYankkxfTxw
Message-ID: <CADnq5_PNTTytPB_CDVSVFJ7F77OZsNLPg=XJiyFZCA2R00rQHw@mail.gmail.com>
Subject: Re: [PATCH 0/8] drm/amd/display: Fix and cleanup analog encoders
To: Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Ray Wu <Ray.Wu@amd.com>, siqueira@igalia.com,
 Mauro Rossi <issor.oruam@gmail.com>
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

On Mon, Feb 2, 2026 at 7:47=E2=80=AFPM Alex Hung <alex.hung@amd.com> wrote:
>
>
>
> On 2/2/26 14:25, Alex Deucher wrote:
> > On Mon, Feb 2, 2026 at 7:17=E2=80=AFAM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com> wrote:
> >>
> >> Fix a "black screen" issue with analog connector support in DC.
> >> The Radeon HD 7790 series seems specifically affected.
> >> I recommend backporting the series to 6.19 to avoid regressions.
> >>
> >> The series also makes the analog connector support more consistent
> >> with the rest of the DC code base so it doesn't feel like a hack
> >> anymore, ie. it brings analog connectors a bit closer to other
> >> connector types.
> >
> > Series looks good to me.
> > Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> > I assume Alex Hung or Harry will pull this into the DC promotion testin=
g.
>
> I will send this series to promotion test next week.

Did this get picked up?

Alex

>
> >
> > Thanks,
> >
> > Alex
> >
> >>
> >> Timur Krist=C3=B3f (8):
> >>    drm/amd/display: Use DCE 6 link encoder for DCE 6 analog connectors
> >>    drm/amd/display: Fix disabling fastboot on DCE 6-8
> >>    drm/amd/display: Don't call find_analog_engine() twice
> >>    drm/amd/display: Turn off DAC in DCE link encoder using VBIOS
> >>    drm/amd/display: Initialize DAC in DCE link encoder using VBIOS
> >>    drm/amd/display: Set CRTC source for DAC using registers
> >>    drm/amd/display: Enable DAC in DCE link encoder
> >>    drm/amd/display: Remove unneeded DAC link encoder register
> >>
> >>   .../drm/amd/display/dc/bios/command_table.c   |  3 +-
> >>   .../drm/amd/display/dc/dce/dce_link_encoder.c | 58 ++++++++++++++---=
--
> >>   .../drm/amd/display/dc/dce/dce_link_encoder.h |  8 ++-
> >>   .../amd/display/dc/dce/dce_stream_encoder.c   | 23 ++++++--
> >>   .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++-
> >>   .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 58 ++++-------------=
--
> >>   .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 +
> >>   .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 +
> >>   .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 ++++-
> >>   .../drm/amd/display/dc/link/link_factory.c    |  1 -
> >>   .../dc/resource/dce100/dce100_resource.c      |  8 ++-
> >>   .../dc/resource/dce60/dce60_resource.c        | 11 ++--
> >>   .../dc/resource/dce80/dce80_resource.c        |  8 ++-
> >>   13 files changed, 127 insertions(+), 81 deletions(-)
> >>
> >> --
> >> 2.52.0
>
