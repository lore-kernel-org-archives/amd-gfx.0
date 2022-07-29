Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32614C00144
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jul 2022 10:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7775711229A;
	Fri, 29 Jul 2022 10:05:59 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8FAB1121C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 10:05:44 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id i13so5199004edj.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jul 2022 03:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=0ijr9Wj2IV3cnZVVkVYC41Kbzvxycpz7WGkovYZSJlU=;
 b=XCxN33f3+lZ66jHLE6OXeyhIM0Q4Fh7set/FWu9yUQloH8dOJkKRtqtXEFlMymr5oX
 H7mWp3KJ3sWYdAyzZ56X8FZa+pFGX/gL6tM8njQtWnMtT4uX8pTfx+vxT5Z4s+xDHrQI
 Su3pFB36k90W+2JU5UdYkBkKSYUWus/gV5wUXmjaGWttHC13CGWCp/yJtkZwdHQSFQn2
 /hHIIR9htZ0jax499e8s411UgVe6BwnwYEDF66B6kg6kT2Fk/tWVUesb4aybkUH4ftXv
 US8eUDoyYhsLhv14cQ7g/utQ31/CxjDPzcRcsPn9YzJeGMNAjL1jF+eVvpaY0G2vPPpa
 KO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=0ijr9Wj2IV3cnZVVkVYC41Kbzvxycpz7WGkovYZSJlU=;
 b=mNHTuZ8u5WBzb99+bbVi5RjIeTbEjxD7Nkj+m1pSQyc0xyAE/UNN9YoZAoohR3JwtE
 AK9ll5PAuB//C/yLJoLtOeVt8G0mVguzuG+3cdwqouw5qPI/5yqi7NYhBBPj2vVJBO4y
 W0FNd08fI3OUP8cfHuEZycP65Z1XuwXEPLKrLI1otx0SAr09xlZHcGmBTGHxRZMigNBY
 1Fj977R/2LNcrRFxhz2Dg66dd9kpdKUM29YAyhCVyWBlTBfySR3TR+Tuhvtm/3VS7FP6
 niwahv1AZMl4Fn2fX+IcWl2N+SgX70EROgERvUZTjpjdoWD/0IrJh+vqcuB0iEl5Yiuh
 pgJQ==
X-Gm-Message-State: AJIora8er68iZZejbMpSkJcEoHinqnXs9lslzE1VeO9X/sz5Mlss+1EO
 8/g7LXIG1e2P/K/VGTlYKmLbpMJQkBD3D3iTwhNO3tYHkC0=
X-Google-Smtp-Source: AGRyM1vATTivLqxMmmrrVXXdfkxSkNvbYnApfHl6M0QqmbcQ8laKmlysue76xA5e75hmR+69+E043qvdVlgtIpRndhM=
X-Received: by 2002:a05:6402:1389:b0:43a:ceea:93fd with SMTP id
 b9-20020a056402138900b0043aceea93fdmr2819155edv.64.1659089142976; Fri, 29 Jul
 2022 03:05:42 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?THXDrXMgTWVuZGVz?= <luis.p.mendes@gmail.com>
Date: Fri, 29 Jul 2022 11:05:30 +0100
Message-ID: <CAEzXK1o+57sPVgPyFoQMkAyqzOko6Td8O-f-6eP_qLn0DkYs3A@mail.gmail.com>
Subject: Please consider Open-source OpenCL support in amdgpu/mesa
To: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

Hi,

I am an Aparapi project developer that has been struggling for two
years to get an RX 5700 properly running OpenCL applications.

First of all, as an end consumer, I would like to congratulate the
open-source amdgpu driver for its stability and performance, as well
as the team behind it! Unfortunately I cannot say the same for the
closed source, proprietary drivers which have been a nightmare in
terms of quality and stability and currently the only way to have
OpenCL... which in reality is not the case, because it does not have
any stability.

The open-source driver has been superior in terms of OpenGL and Vulkan
stability and performance, it just misses OpenCL to be complete.

I am not expecting any reply on this, nor that it will make the
Open-source OpenCL support for AMD graphics cards a reality... I just
want to share this reality that I am experiencing for two years, with
many amdgpu-pro driver versions tested and also the new deb based
amdgpu-install drivers. None of them provided a working solution,
neither legacy based, nor rocr based ones. The machine starts running
a few OpenCL jobs, which after a few seconds lead to a black screen,
followed by GPU reset and machine hanging. The same OpenCL jobs run
fine on a GT 1030. There is also a big issue when running the RX 5700
as a secondary GPU, aside with the GT 1030 as the primary card, which
causes the amdgpu driver to fail to load and renders the RX 5700
unusable. I just wanted to share my experience with this card and hope
for a better future.

Please consider Open-source OpenCL support in amdgpu/mesa.

Best regards,
Lu=C3=ADs Mendes
