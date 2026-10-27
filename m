Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFB606A31D
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Oct 2026 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zEqzu35H
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F90810FC34;
	Wed, 28 Oct 2026 12:59:58 +0000 (UTC)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A79810F5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 15:47:39 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-7c33cc572e6so946709137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Oct 2026 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793116058; x=1793720858; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0DswmWoXofnI9OqDL5xwhT8a7C+9NrwyAXFpDB+jHbw=;
 b=zEqzu35HkDHYc4nlHYza96L9JMjXdPkEYcWNpijXJxXGiZ/PWUKv6B9ws7ZohdSns+
 k4mi1OZq3kt30GMdGVTjenIvLKWetGk+E9lhRXeeDtxcnG9gKPZnnEZ/YW6iyyg3PM3D
 N++d+VGGD76JWYHik/5oROAlGVZnTxHAy0DcD0hNs11Y1plAIquQzLUujfHOjaShzBVR
 xsPK1ldbbHiWiZueaS8cJ+Mvpod0NjS2ghd7/fuOuxjLkLcHXvVDTFrodAKpR1W/Bieu
 x3ln93HfD4ME4FoIRw+IHiHLP9VTl3/gy+yYWuzevMhCg5OtPOv18dBUvjvl6HINdn9+
 HmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793116058; x=1793720858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0DswmWoXofnI9OqDL5xwhT8a7C+9NrwyAXFpDB+jHbw=;
 b=MPS3WqhlSnDcOU79oafSITusINhQO/6Aw6p4rBYUi6SPWto+sxG9mvlkVuul5rdeTe
 BKK/NkhWykvZHkZeMrBekoUBq94WJJMVGaGYTvft8qxUmTERVbi3TfoSqllwBuZK/BVs
 aNX9R0AsA3c2G5IbPcEn//R+psuc+umZlL4F5CetNk7jgQ57H3ULQDz//LblFPoPbDYX
 YjThgdDDUCgBQkUJgFcaP3wF1/Mi1tpJG3AEI0RcJRv8h1TWi7wrpv4zYq2gsOlovv1v
 80daIs/eE1x3u3NAqiZTGvBkuPUVizva3/uMZrT0oNWldwmTjbVpcNL4U7uQ7nbABGan
 iT6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzZ54IXhQOvRwV6CZ4Xjf62Tdy235YdyxKiQ060p23QKCVPOglD77dNGqRS4Nb6nZYo0UYftWa/@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJSlkNr/H6uxzqB00lwkEoBbfaRl7vj/2Y2u0Zf5ik3Zc420gL+
 A8fOezt4MXSM/PDjUT1ijZFM0W7SIYrQ8AybAECPso5xZujkW1YTMz8l
X-Gm-Gg: AYBFou0Ak1S6dMBPSGF6VjU4Jj4lhOqCTDhBixWtLTrG0GPz7hl8rj4mEaw0vYNH/Fz
 zOM4CCUoO+4h0KkjIpilWDEzCcZfi1Xvd2JXW+Qq+fIoJonhV+wyQO+AnlseJvGk2n3WzP1ZKLx
 eMcI24kk76Bc7/voIp1mo5LBG2K73ONTjj2IFqY7ozm04Pr4um1NftwWIi40ZT0M1XhwC1Ov+gw
 qtsigG3mEBuSkdUI1e0UfOnsKkLzrM52VIs3hptChd+csopXDL+EXZw/1m1P9hG6vHAB75StWSG
 BUhky1peZWCxb4g4QibhYzqsVL9eep5gDuF7IKwnwHEcBiTeSGZKqmXMxT6ww4bgB2CW8Ajf9cA
 0ekeYuCVeDoa/e2Tlwjq5mx01eDYnNzTBx5faumCYUEPna4dYk2V4RjBk+KjDYlPqMsislKCyjb
 tuPURS99oqPHUNSei1OunhXuaMiHzImvcmn8+LizPa2qw6xCw9mhJ0MuaaE42YcMpLPPI56mZmM
 1jf5ko0Ok6xzYXUiWziyObI8viE4xmVbYfAmkQKeh37TUQvMeJfX54+wk/5fU4fNc2pcFcwGtQ9
 5n3PvfgB0JSbPXI=
X-Received: by 2002:a05:6102:390b:b0:7bb:64cc:1362 with SMTP id
 ada2fe7eead31-7cea1300c05mr1004091137.6.1793116058224; 
 Tue, 27 Oct 2026 08:47:38 -0700 (PDT)
Received: from localhost.localdomain ([177.155.254.22])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7cea3973caesm2799894137.2.2026.10.27.08.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:47:37 -0700 (PDT)
From: Matheus Tagliari <mptagliari@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Matheus Tagliari <mptagliari@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] drm/radeon: process the VCE interrupt on SI and
 Trinity
Date: Tue, 27 Oct 2026 12:47:17 -0300
Message-ID: <20261027154719.155006-1-mptagliari@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
References: <20261022114754.865669-1-mptagliari@gmail.com>
 <20261022114754.865669-2-mptagliari@gmail.com>
 <88c61950-125e-4109-955e-ce09ebaab7af@amd.com>
 <0c7e45a13fb78064390818bb501e754b62f16f6e.camel@gmail.com>
 <20261027001506.27266-1-mptagliari@gmail.com>
 <6e0b5af2-692a-4b2f-ae20-9c164e7e42ed@amd.com>
 <d451b9a185817c576ebb7943a604fd1952470412.camel@gmail.com>
 <CADnq5_OGgbFOJtBu7SwvvnaN01F=RSqtxZgBhJ1fty4pwBHmVg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 28 Oct 2026 12:59:51 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Alex, Timur, Christian,

Thanks Alex for picking these up, and Christian for the Trinity
background.

Timur, yes, that is possible. The only place where Trinity/Richland
gets the interrupt enabled is the family check in vce_v1_0_start() in
patch 2.  Today it reads "rdev->family < CHIP_BONAIRE", which also
matches CHIP_ARUBA.  Narrowing it to

	if (rdev->family >= CHIP_TAHITI && rdev->family < CHIP_BONAIRE)

enables it on Tahiti, Pitcairn, Verde, Oland and Hainan only, and
leaves Trinity/Richland (and CIK) as they were.  I built vce_v1_0.o
with that change against 6.12 and checked the gate against the
radeon_family enum: SI on, ARUBA and CIK off.  On SI the generated
code is the same register write I tested on the Cape Verde card, so
the earlier results still apply there.  I cannot test the Trinity side.

The handling added to evergreen_irq_process() by patch 1 stays
harmless on Trinity: with the trap interrupt left disabled it is
never raised.

Since the series is already applied, I did not want to send a v3 on
top of it unasked.  If Christian would still prefer to keep Trinity
out of the picture, especially for stable, I can send this as a
small follow-up against the current tree right away.  Otherwise I
will leave it as it is.

Thanks,
Matheus
