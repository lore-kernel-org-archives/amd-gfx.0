Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1BFC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 06:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 096B810E0BD;
	Fri, 17 May 2024 06:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EDNycSbr";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE30510E0BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 06:32:06 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-65be7c29cb1so720483a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 23:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715927526; x=1716532326; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xvVsjscCXBsZCJkN9lbKIky69d5kiEmwKe7e99mSdfw=;
 b=EDNycSbrdtWowvZOqmrBfeMP+XxTc+wZ3bWXM0ZfPdzDsZKcVkfcwqWNhBENnAXMgW
 gsycdTwkgZ/nR2nF7YJHoKdR7srynLmt8Bm3dTaC+fPaKnFYdCvscgvYXH5ZzpieyPa5
 /xySlAucVnKVjCME0EL+SSqsk0IVJ3siK7sk+vBkEeafc3IKR68UAIqMbx2gdSvSz8Ll
 7dZVfg6sG45M0bFQMVhkdxJRlqyEM2W79INhIzfUpOvqSJA19Z7Faq6ZMYzSiVXeiyAy
 ccqFJpfi4/o0CDcmm0k07zevrRdgaJyaRs1iWERZfJ1wn6yeF9TPa4RX2XE6ujueKdHT
 htFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715927526; x=1716532326;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xvVsjscCXBsZCJkN9lbKIky69d5kiEmwKe7e99mSdfw=;
 b=ObWxsJr4oD+nHpxMFyNLhk7fkGqBJk93HwBp+lDGlFtMMle0QyINGdw5tyDb+amxwi
 p33UNyDRXrijD4NWqulR6h4oPAiZpLLBZh+cnzqNReCeWT896IM4arKwMoDfM1hlMXTl
 4WWnJ0LhvDweYor2+0eO2mGvpssElsxQgfyW6dGGmKzrbbsj0m9HBGKt7xo9lc9ThEkF
 dOIJW9HjQY2/aqOmZvBTKbBD57FBfGqEK6Voo4YoTyPg2w/FK949+tYglK3juzpN3vfI
 6J0IHOOpEnfEMCM45bmkZzwDW2+/bFIlqSJUnnH2HL41Yhy1qQyrmLhH31JtS39ODIBA
 wT0g==
X-Gm-Message-State: AOJu0Ywe+5SBrfT7KCDOZlYGDtZw0kiys2C3nrcqyqdEWJ7t89yyOyb9
 8IZ+a7CUihkFlyVIMH3iiSVe3cIYUFdhWBca5qfGpMAUBVRhWpdUmGs6FKDx1/qKpfCw2jUqO73
 dIOcZywYWD3pdOBSGw+jM7qZGID2W9i3J
X-Google-Smtp-Source: AGHT+IG9tgBWPH0sFsNong8ZxO615xmy9F+pLOAJDfz3UrOCq2//lfNXtpIwpp3qZtmJvTv3W3A72adzgJkSkpvAdjs=
X-Received: by 2002:a17:90b:98:b0:2ab:8e59:9da9 with SMTP id
 98e67ed59e1d1-2b6c6ff020cmr30780999a91.6.1715927525732; Thu, 16 May 2024
 23:32:05 -0700 (PDT)
MIME-Version: 1.0
From: Mauro Rossi <issor.oruam@gmail.com>
Date: Fri, 17 May 2024 08:31:54 +0200
Message-ID: <CAEQFVGbaEx8mOWKy9bcq8FLFfq8Q+xE_hwk4dq5weKjNROcOGg@mail.gmail.com>
Subject: Request for Information on the current drm radeon Atomic Mode Settings
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Cc: Alexander <alexander.deucher@amd.com>, Lee Jones <lee.jones@linaro.org>, 
 Michael Goffioul <michael.goffioul@gmail.com>,
 Jon West <electrikjesus@gmail.com>, youling 257 <youling257@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000a1ba1b0618a082c1"
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

--000000000000a1ba1b0618a082c1
Content-Type: text/plain; charset="UTF-8"

Hi all,

with Android 14 QPR2 there were substantial changes in graphic stack's
Android HAL (Hardware Abstraction Layer),
essentially it became mandatory that hwcomposer HAL module supports AIDL
Android Interface Definition Language,

at the moment drm_hwcomposer does not support AIDL [1]

Project Celadon has an HWC3 AIDL implemented [2], as a patch on top of
hardware/interface AOSP project, there is an opportunity to use it also for
non Intel GPUs.

drm amdpu in kernel already supports ADF Atomic Display Framework, I would
like to ask the current status of Atomic Display Framework in drm radeon,
because Atomic Mode Settings seems partially implemented since 2010-2012,
but ADF capabilities are not exposed to user space.

Please, I also need some basic (high level) information about the
outstanding changes that would be required to support it, in order to be
able to use HWC3 -> drm_hwcomposer with r600, r300 chipsets.

Thanks for your informations

Mauro
android-x86 team/Bliss-OS community

[1] https://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/issues/80
[2]
https://github.com/projectceladon/vendor-intel-utils/blob/master/aosp_diff/preliminary/hardware/interfaces/11_0001-Enable-graphics.composer3-AIDL-HAL-service.patch

--000000000000a1ba1b0618a082c1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>with Android 14 QPR2 there were=
 substantial changes in graphic stack&#39;s Android HAL (Hardware Abstracti=
on Layer),</div><div>essentially it became mandatory that hwcomposer HAL mo=
dule supports AIDL Android Interface Definition Language,</div><div><br></d=
iv><div>at the moment drm_hwcomposer does not support AIDL [1]</div><div><b=
r></div><div>Project Celadon has an HWC3 AIDL implemented [2], as a patch o=
n top of hardware/interface AOSP project, there is an opportunity to use it=
 also for non Intel GPUs.<br></div><div><br></div><div>drm amdpu=C2=A0in ke=
rnel already supports ADF Atomic Display Framework, I would like to ask the=
 current status of Atomic Display Framework in drm radeon, because Atomic M=
ode Settings seems partially implemented since 2010-2012, but ADF capabilit=
ies are not exposed to user=C2=A0space.=C2=A0</div><div><br></div><div>Plea=
se, I also need some basic (high level) information about the outstanding c=
hanges that would be required to support it, in order to be able to use HWC=
3 -&gt; drm_hwcomposer with r600, r300 chipsets.</div><div><br></div><div>T=
hanks for your informations</div><div><br></div><div>Mauro</div><div>androi=
d-x86 team/Bliss-OS community</div><div><br></div><div>[1] <a href=3D"https=
://gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/issues/80">https:=
//gitlab.freedesktop.org/drm-hwcomposer/drm-hwcomposer/-/issues/80</a></div=
><div>[2]=C2=A0<a href=3D"https://github.com/projectceladon/vendor-intel-ut=
ils/blob/master/aosp_diff/preliminary/hardware/interfaces/11_0001-Enable-gr=
aphics.composer3-AIDL-HAL-service.patch">https://github.com/projectceladon/=
vendor-intel-utils/blob/master/aosp_diff/preliminary/hardware/interfaces/11=
_0001-Enable-graphics.composer3-AIDL-HAL-service.patch</a></div></div>

--000000000000a1ba1b0618a082c1--
