Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC5B606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Nov 2026 22:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LImKCfbG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FDF10E38A;
	Tue, 10 Nov 2026 22:20:47 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAF6C10E38A
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 22:20:41 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b56bbf8330so3348373a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Nov 2026 14:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794349240; cv=none;
 d=google.com; s=arc-20260327;
 b=BtJblNWuMch9+7lfmAfi8p6SJq5FnOUyZA3C2PLHp95yMaY0TGEaL7P6ux2v3M9Y3C
 QJYIGm98nTmg8GbdXHtFzX5o9VWR1vPrZYEWkWXNzUOEBBfF/4PxmmsF79nf5xKUfdrv
 YBxnw15SzBYBW7oAUDveIaux9K0EIS2dOr305MOycr2DMPlTlBzH/si6KHT1dwZF7E/e
 oVGr97z4/IejlRw9bsky4gQUtzwz1aH8pbz1rzNWrSGaHsluHnqHlZcj08TQcWeV6sQj
 C1LA94XQ35g+QUK5d+4YuE/AKcrwwjRzquod7xSmiISjkv0TvKxK7+8FM7HkaJ1qMHPg
 YHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 fh=LRBbj0l23OwlZT5gs0XhYX2ByiDRTxV+wO8PvOABuKY=;
 b=caM1O4m7WVJYAMlGlmRxtqCj5UX0PGcPI4ZU1IvCJIevT4PAocXxWq7W0i6i9q6KRx
 pKBP0wXU1wUSsVS7z+pNEtxkURLKjc31DNRoX/JkRIIZyhf4Se4XI9DOyQm1U6DM9UfR
 O6JcPh4HkFC4x5lz8ijpxv3Znur9J9NMW3JCECl3v9HdnIixEQbYIlnPixVg46AAug8g
 5GKzhL3oGPMdDc/CJScIMQMSpQaadgejticTFE0thX4fl+umWqdg1Qiw4qgmVsxzUXC1
 kzDf9AUWsDrpAE74t1P3AYtKbSTvLKw1rPza0V11Mc4pbup/aWhKoQZ42dWgCaei66Ys
 l3hA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794349240; x=1794954040; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 b=LImKCfbGmx+1FDeOMzEPrJOGjTdFIiXW4T8Z5MlBotn71iOBONrZf9sK/XjLaVNj/z
 rVZKRnFFc+WpOWMdgwddBMlllDTPKMbwWwmcxzIwTWhtQ8u46TPyI9BaFUZg3IrAZ9d2
 yvrbQpNeESO24wOgFY9S7IO23PaaNxAbO1ZDUBEy0QnfdQZPquaZngncJVvaoTSZxwFH
 0vK0SnlG0SpkgGdpCedd7M67t4mD3JC1HHV8X1B1FZnoxavmIJ5qcSaMGlnSwHy6jqNA
 ZOTZ+NI42qvfZ88JwqZmtgaK3+7JBMX6OmHgKMf3H8t/CdfJeH2bodKnb19GYih2Vdwb
 aJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794349240; x=1794954040;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m99sVTP2KDQCUkIDg8pOb2kGKHgwxWRF675z9CkWM7I=;
 b=HoK2G7iSuPqRJDJoBwQQFoQD1L7NpvDUtZdkkmzaR2JMXEo2PmKZZkthLS+fVlxuvh
 eCuon6aQ8lPjD0aQLnLbGip34t1QtCWMVcIfqcrIWwxO6PHwvoIdeS4pTm4fEYxMc2X+
 ISNRgXaDOwxr80lXpErBPXygHeAe4cT/2SWjNb27tDq0TWqfDXUsLCaMf4oBFvUkSBN8
 aOcljkC65JhjkDHi03jgnjEjtnF5sBaWNyMjV04R6EQqkkXv9LqI+2dpEj1CJRwwzhUn
 60R2PAvVvhMl5Ly6edrdI4sXCrNfIVahwlQivF3amKODK/7BhVdzV72EJEC+FhA/PaUD
 clfA==
X-Gm-Message-State: APuU4Z/TfCs3EBW0soMKZiUkH3O3G7m6Ol9blOBOBTrwJZV8TDu91/6E
 XTrdZ5zJyLYCAEdsj84Ls9Xn8B4abPGM54QXUE3+BgG45PzkLUW3Q7o+C1Btx1VkyrrClI/Yw7a
 lG9ykIBpCKnHVCFYfKIkaeeXjuxRoUFgQ5O1JKOrwnw==
X-Gm-Gg: AYBFou3xT0L5eFUTO8O3ZAe0DAWItAidbpy0QbIrljqzARCT1yQbLf2TDW9uL6nt3I3
 rbOAZlJ+hDkjtz7f1BlApZSD/n5py6V5UWiDqCXeUNbZlLGAXbK1WufanL10FpF9NBfemQ8leW8
 zf7KBg/OSo1EFWd9G+jLQkLJJLRPaXN9GYy+VFoRAmsBa2HCXX7+1M3gXfzPyMQmAzQPlqqsW8G
 uSHC+u4Dcq6DTq/NWChk2E/K2zLIcl9LPARlDh4h0vmmirAiXqP1W54K/O7jwj7KpolDTxLHyiw
 F8ku1OGFCbvsiOuqXVfwmUnk0o8auzwjOnKLfaGXA7MCCmSCwEdlNNms/cpJI3f0TwiYT2Ok7H0
 a+C7sRTHqhNvqPJP54+Tiz9SdOVEC29GyX7N39o3ob8g2NM3A7uDVdYfdfNMxPLCYFvFoMYnA
X-Received: by 2002:a05:6402:2279:b0:6b4:e433:ee16 with SMTP id
 4fb4d7f45d1cf-6b777832d28mr414278a12.43.1794349239980; Tue, 10 Nov 2026
 14:20:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
In-Reply-To: <20261110130956.160024-1-andrzej.piatyszek@gmail.com>
From: =?UTF-8?Q?Andrzej_Pi=C4=85tyszek?= <andrzej.piatyszek@gmail.com>
Date: Tue, 10 Nov 2026 23:20:03 +0100
X-Gm-Features: AclHuK9T0jEWuuyeKcsaFJF8n0gaPG1UTvH-Fz13rz1eUpDPmmJS8CQsHVhEDC4
Message-ID: <CABwS-fbOhshTN1KQV81LNRmyZ9cOvJsHgyYnOQvosLUF87iAog@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amd/display: HDMI FRL training fixes for slow
 sinks
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Relja Vojvodic <Relja.Vojvodic@amd.com>, 
 Ilya Bakoulin <Ilya.Bakoulin@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Please drop this series.

As Sashiko pointed out, patch 2 raises the LTS:3 timeout past the HDMI
T_FLT limit, which commits f38686268b0d and 007834be6760 tuned for
compliance. I'll send a v2 that keeps patch 1 as a general fix and
enables the rest only for the affected TV, through an EDID quirk.

Thanks,
Andrzej


wt., 10 lis 2026 o 14:15 Andrzej Pi=C4=85tyszek
<andrzej.piatyszek@gmail.com> napisa=C5=82(a):
>
> With FRL on by default since commit 5fd3b60d9b80 ("drm/amd/display:
> Enable HDMI FRL by default"), an RX 9070 XT mostly trains a Samsung
> QE65Q80T (2020) at 6 Gbps x 3, where 4K 120 Hz needs DSC. Windows on
> the same machine trains it at 10 Gbps x 4.
>
> The TV needs one TxFFE step at 10 Gbps x 4, but requested levels never
> reach the PHY; with patch 1, the driver programs them right away. The
> TV sometimes answers an LTP request only after up to 967 ms, while the
> driver waits only 220 ms in LTS:3; patch 2 raises the limit to 1 s.
> After waking up, the TV can stay silent at 10 Gbps x 4 for up to about
> four seconds, but link verification gives up on that rate after one
> attempt; with patch 3, verification tries the same rate again first, as
> the enable path does.
>
> Tested on 7.3 with an equivalent backport. Without the series, 4 of 6
> boots and TV wake-ups ended at 6 Gbps x 3. With patches 1 and 2, 16 of
> 20 reached 10 Gbps x 4, and the other 4 are the case patch 3 handles.
> With all three, all 63 boots and TV wake-ups over 12 days reached
> 10 Gbps x 4. In 13 of them the sink stayed silent at first during link
> verification and answered after one to three more attempts at the same
> rate. On amd-staging-drm-next the series is build-tested only.
>
> Andrzej Pi=C4=85tyszek (3):
>   drm/amd/display: Apply requested TxFFE level right away in FRL
>     training
>   drm/amd/display: Wait up to 1 s for slow sinks in FRL link training
>   drm/amd/display: Retry the same FRL rate after a sink timeout
>
>  .../display/dc/link/protocols/link_hdmi_frl.c | 56 +++++++++++--------
>  1 file changed, 33 insertions(+), 23 deletions(-)
>
>
> base-commit: 47df73aa49d1988c8f684b7caf8be6570e966844
> --
> 2.56.0
>
