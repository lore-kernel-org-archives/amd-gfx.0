Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CE6C88E7F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 12:05:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9813B10F473;
	Tue, 15 Sep 2026 12:05:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20251104.gappssmtp.com header.i=@dowhile0-org.20251104.gappssmtp.com header.b="TooONS+K";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8170610F473
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 12:05:52 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254fa650c8so35888266b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 05:05:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789473951; cv=none;
 d=google.com; s=arc-20260327;
 b=eeeE8TW5zHVetiyragFv0btsUqRNKlaA7BD2ztEu+NKt55fHISBRjwfi94M2jlI81l
 wDneQsfN3bDJSVjG4XI29Lub+FUBNGFHr48xUGdNGKpQQpErfIkFtdYy5WVI23IBLGqh
 efd456p9ayDSad1g8p9AY/huvZmW//9toV+mScEIR8JgDr3Yq7OP8wub/D5oRPNWUvod
 zcrM3vdSH6C/VTlu51yMQ5TOPmxJCVNGR/BU4voDxMFylgWJSIerDjUNmPAYgx6Qyka0
 gHxwNUV5ZPqb/BKmH2qCQsufka9+6w2KcljYXEMcqV3UJ84vzJfb1GFmFEu9tbm+XLVW
 Pp+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 fh=6bwq7IFTfGmqou4DpnUOkv4PF9iothGSdER/bTXfEXs=;
 b=AGXpvt1YjHvc6rFZvTKgehXN31bBiL7kUHnczaYga1L8aKhixAEB29bFLvG9v4Oqr1
 5TCCAioALVrW/SxI7V8oQfa2VVTw6I8NuLOF0Yzw4VRXN1+2dgyYRmMA6Mp9pwl78SBQ
 Yt17oryvckaBDr6FCDOnK5zQmXoAn2cly9zrAG67v/dABEzMNNrdGBeRGVUDtF0RlY8o
 5WmeN10fleiM09Zs8lVF0cNYx5YtfTSHuqc9vAPFsfFXI6HmbLmzob3Qx4+Rv1+FLt8o
 oZGXBZCnRUx4NlPAwSQbEByFbDgvJyF64Bo92UcgD3urqiKD20CakUw+Ajt6C3r71weO
 KrbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20251104.gappssmtp.com; s=20251104; t=1789473951; x=1790078751;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 b=TooONS+KqJrsXnZEMNiQzW5H0GYYipoG/k4HNIuN1iGSwjSSpVUJEZeyECTdb7PFy8
 qooEm5rmuSv7JPX/6SnVDlQanE+9wGCJ8v21Unf+ntZNtnGIsf2xMGeAWULjin1xHT3K
 p0+X2ICh3VGonQQ8PT3v/7mfDNTnWqQQqtNt24xy7gv8iO8f6Pbwkdg5wgjxqzdkszoR
 OKxjvIYdSg95lI75kCsPyKtvkoMB5/boRf94/7SJFrKog9sgWNZWbhocrBTxfOQV/61m
 Ojg0BvjkyKBjVquaFvPYVy+0Ralzw09lDF9ALbHxfJb/jce06AM3uJM54YPOhFAC90LV
 HByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789473951; x=1790078751;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lGR769Q1u6VnNaP0O+YJGZMTAmF/EIXzO8p0WIflTDA=;
 b=xFSCDToTNk4CXqt2lVNpAcodmF5nQauW3gVyVSaEWJV8xQfuNNhdcSA93ig2pjHN+X
 5PfmMU/APL/dbRMsauZIXPPKm4NdBhAr2G5BUsJlhyq4CsYlXrG+3bOHQGOFMFdyeQdC
 /WLJhGoIajHD/fbQjCwJd4bityaOXF8xlv2b0qIpLK6pFkS010L/LWuTc1/+CKptTBtA
 IxBGBxHqAhZwIQXPzwnKM/tmfTg0WUdb2VRlZ24CxjwskoHmWTzs/n56kZXfwM6bzskK
 3Qf/3RrD2/jUKvjrRMGiFyLtru9ogxd/zy5P2EYAggtojxRmFHwiv4Zi9HGsvxf8FFu8
 BMDQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbVqC/b2+zbhn+mSv7Ah6AEbw8NBi4QW4EzBpY28gPJi32fnY4w8HNlNky9sFl42f/mte8aHqQ@lists.freedesktop.org
X-Gm-Message-State: AFuF++n4l+XQ7GJOxUYkAonlK7dZTG2HIUCQDNQGn9kebhWRP9OpobM2
 rSfBBKmC1lUk5dZmUAE10EFw3IHNAC+E3Mn5Ncsj/aU7dwjFlcd6Yt3blWo0j8K3TewJAulAWLu
 HiqBWKrK6oF8wB9rAJjWtimJvVwWqbYViHqykNJzG+A==
X-Gm-Gg: AYBFou3xGDrHwna/jtBztve8TbSbB3HaoCtsejlVChPL7GxBSq44BipLHk9LLZLmMWA
 aJwK4er4ObFiHBSqwiloJY1cYwDAF3cJ/nWqHCqd2ERJQRxqKAviYWTmrHEYKIXzh7+17hLP/cN
 BVgnxEx/ncslgXT+zBNLHQpZna25fPaGglfG8zAMxDiuv/eWaLxnynUYQ17ftQOC6mtmkPmhTJW
 vfzo+u11HKtyr3SJIxfzmSDjPu4AZjjnI7FE1p5092frxX1uSEJAXGv7Jan81YfLiicjxxaW1qV
 y3ycrtkEHns4G1ovdIPzba3G2rGv88Af/XtRut6Y55zWF3+28AOKLDA=
X-Received: by 2002:a17:907:1b0d:b0:c26:19e3:e98d with SMTP id
 a640c23a62f3a-c29d79ba69dmr56393766b.45.1789473950712; Tue, 15 Sep 2026
 05:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260915101251.1711103-1-mripard@kernel.org>
In-Reply-To: <20260915101251.1711103-1-mripard@kernel.org>
From: Javier Martinez Canillas <javier@dowhile0.org>
Date: Tue, 15 Sep 2026 14:05:39 +0200
X-Gm-Features: AcwNN1WLUwMQbIGB6Ob0Tb-fP2UVFOJ6BK8UyVWfKkJxm9LxXgSzgCNWjoBYN2g
Message-ID: <CABxcv==TMPeR00BGzU6pvpDVxS8Vh9C6f+axt2oGGnjG4dxP8w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu_dm: tests: Fix wrong variable declaration
 after merge conflict
To: Maxime Ripard <mripard@kernel.org>
Cc: Simona Vetter <simona.vetter@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Tue, Sep 15, 2026 at 12:12=E2=80=AFPM Maxime Ripard <mripard@kernel.org>=
 wrote:
>
> Commit 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> converted dm_test_plane_create_state_initializes_state() to call
> amdgpu_dm_plane_drm_plane_create_state(), which returns a struct
> drm_plane_state pointer stored in a new plane_state variable.
>
> However, the merge conflict resolution kept the old declaration
> (struct dm_plane_state *old_state) instead of replacing it with
> struct drm_plane_state *plane_state, leaving an unused variable with
> the wrong type.
>
> Fix the declaration to match what the conversion intended.
>
> Fixes: 2bcec01cf105 ("drm/amdgpu_dm: Convert to atomic_create_state")
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
