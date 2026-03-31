Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D5710FCADA
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 545A410EE9B;
	Wed,  1 Apr 2026 18:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="IYHYd1DD";
	dkim-atps=neutral
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com
 [209.85.167.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F37710E8C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 13:46:31 +0000 (UTC)
Received: by mail-lf1-f45.google.com with SMTP id
 2adb3069b0e04-5a159c1e65aso5363926e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 06:46:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774964790; cv=none;
 d=google.com; s=arc-20240605;
 b=CDmQ3Op9QCd8atWlj7gqlh1SHYoBfGNqaFBua7NbE+y+NRKSdaZmv7qLPUSU2/psLa
 7/piP7sSnYXnWHLTRrS/jBdbH1Qt53eOOVjmr53KgCHWCvdUbNSF0q+mRrxf1FBvzLTv
 L7bv/itYAn2jFXLIh4W8U2OYUpfX/x0KBJgoPVuAUfA3XLz9dadtzEsWe37OAe2PagnE
 P1GWFknuWblyfAPyeSsDw3mgzFOLkM4Bf5jjgUmeVBt3uP7kw2sj1dKeO0hKJhfkPK9X
 6CP5U7MRLLPw4zzNGzQabrMDpZbVV6dpuHswJFnZy87lpNpGv196NCx49fhBM91j8b8H
 rKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 fh=04XhR+H7MkY5GgqyPpGdFKscY30iQ8CmGbNgiu0fk/U=;
 b=bsikBIEQ4WCB+KbaVwhhcaZouGg+36Z1UKdKaRJhdLsRaqKoFrKpV5940++9NXMnmX
 T+CU/wv0P/aGosnxK3MxZSQsOcv0+3VzkhSXXsVnbeBPKUI1q1W4faQX87VywAED/Bmf
 fju8iA0y5tMGV24AsGe3S8b/8Hqq9sBzD5v6PB3DKPoiys745ze6VnJFq84K+a/hhECW
 m1nxv7912VyOWpzBj268yTLdTeHaBbu6fYAKb3WsOEYedrMVWPV5TAatlbIdqdSNsAEw
 qqS933p91sq6JWVUcbC6F5SxQ2pfOPN7bAYBp4XNoDurm2fDXTaaaHfmx10pJQ2JIg15
 izHw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774964790; x=1775569590; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 b=IYHYd1DDiv6rJwisE+Vn0AryDsD1Q6ds5D4hMRacf8S+kotDJ047Ag3aIKIipy8dDq
 32AgGfh/Y+wQSQl1Xspm1ZzT8VPlHPi+hVdQP/fcm99azEKv+EUa1VnR+qeKjkD7q0eM
 UX36+eG9OY9Iq0up3ffk3j7vLAiKYPVPGXecJ2OqUNrPxrzuPA5GPjV3uoQ5UOBTadMO
 mUCM97QZM67IwFJf10jeLFJT2MAuucC7ZtLyUZBtyI7L1jZuAz+qjWB6jQmxS3EyqmgK
 r8Wm7f/I1ABn3WqreK97SDzMLrmsxQ9MYocLK8OkoRm32q/WxF5XYw9z8YTJh4Qdl7xo
 S7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774964790; x=1775569590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mxC0DjIPnYtMzrcaBFGGCbJRmAlOZeLTjMMOuTaAFEM=;
 b=lk7eo83/JfPoVRE8z6HGzsa8C8sE7CLHSzt3B+X5IyP0W7mHmE199eLuq3EHlwBB33
 ZUGEH3LxO3lF7k4QmtHJYfBw4+2kMtBSuwYKJX9I92vAwt1LiOqlLNwiKHyTJG2Dvj9t
 WzQeAbr+QnMsgDnRgdlGVmPP+BPUZg8q2lCMJAHQvvcf0V4g6/dCPgZSCjYIhS9AErm7
 9/tForAP4Wae4tq/cZ2hG0ej/TmfTTBgAAuT1K/HAzdNTyRCh/Y+YzuYr56ZMECgZUQq
 Camc9aveX9aqsq89UP/gc96AL6mrv0Hh1HGCj11D0lSSbMq/5H28/5Kzrtb9Xx/NmMoo
 zmKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ61IZ3Ip7ourTGwC9EAGQQuDp5nIalPteg3BDWsG87LrwvhC2KA+ma9y8P2NjgItyQRumlWmD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzLAmrV2UqO/i5yYgklwKxE/KjrWDb/V1/+moT/ZAWcLuCMxg3
 w9a6Hbbfm/PVC1Frte01rsw48HDHXvgysxQQo+erAYp/SaWivJHjaBVLp+j+Uh94ywffZpUA8Y0
 fBlTV6Hp38sOKS+u9KGQnxjaqgR4EWXrraC1DrzigeA==
X-Gm-Gg: ATEYQzy/ANH9Ti2UhQUhCKqBsXneDKY0G0dOlIzQ49SCL+K97U3KggeSetqVadHG7+J
 zIvWmRO7VbeIA7Htz0g2D4YaC5ZdzAOsBsfKVHW0smkHKs3UrJaqWVrOBzcV3SoCRT1NspBjv9J
 I4nYt+M8RyCuMwwnzXCufn23d0HT241wHXQ7Kdr5SNt8H13Kr/H9ijJjEY2dELSEEEbbA0xAnWk
 68+LU168Q+fsG14otkgkru7/2IosTDrTz8yA5RKatESpdpp/C00HJ2LG8gcrvLa6hGSk3nQqGLI
 D8OYQ/wtbA3KG6KPU1b1shdjZOJVDYdoXC4GVTpD
X-Received: by 2002:a05:6512:1095:b0:5a2:8513:8a9a with SMTP id
 2adb3069b0e04-5a2ab7f02c8mr6035827e87.3.1774964789632; Tue, 31 Mar 2026
 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260313144715.252069-1-marco.crivellari@suse.com>
 <CAAofZF7bfoL8j-CvFEHBnTcAX-y2hM+TDrPEEHbWh3kxMqnCvA@mail.gmail.com>
 <CADnq5_P-C6pCm8EW9EXhGWNQggg_ycfZcmD9B_BbvWRmSA6mkg@mail.gmail.com>
In-Reply-To: <CADnq5_P-C6pCm8EW9EXhGWNQggg_ycfZcmD9B_BbvWRmSA6mkg@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 15:46:18 +0200
X-Gm-Features: AQROBzAhI9WPFV4ajxDt7sQiqBiiuK86SaTanysaB_e0FiwiKDl-d8m_W4cXJNU
Message-ID: <CAAofZF5x_jqHLe6wcEt59t-tRccrQc9xGuO2tFKijp_R0Hreag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Replace use of system_wq with
 system_percpu_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 Christian Konig <christian.koenig@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

On Tue, Mar 31, 2026 at 3:45=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied.  Thanks!
>
> Alex

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
