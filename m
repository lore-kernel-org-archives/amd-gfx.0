Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517610FCADC
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D925310E640;
	Wed,  1 Apr 2026 18:19:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="UDQOpdOr";
	dkim-atps=neutral
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com
 [209.85.167.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B81910E984
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:56:57 +0000 (UTC)
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-59dea72099eso7147735e87.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:56:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774969015; cv=none;
 d=google.com; s=arc-20240605;
 b=cHqCvS1xkyUt81m6WcvEYRUpSD5BOVQ6RhLlSQSQUNq0DfG9HrYHiVeORLybBu7lSV
 pYyJDO0XtWK+4pt/2R2pvWlgT/OMlP2JVwgPgZFX2rq9LSzpr1FzFVXJDR1R72wT3l4J
 73EAfdIvaP+1Fl5Yl9/A3atCewGoILIXcPZhTlSgimPLk7ysmDGOwb3VQ5hTQKRG8Hij
 RG0McBX38zjWWeR/wU7C18ieTho6ZF3XyvMKWAZ0F49mF7ExgYhES6nQxQ+1LaB+5u4j
 AfzBY1Fj/NScBgOrl7VUZjAdsXeJEehtD3tAn8ZjWkD4icEtsjpqjx8VXVfJoj/w1MTh
 yz7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 fh=GqO7ydVwj2AnQJnol+bJLtbP6nD+UDGWaojOiXLxwbU=;
 b=BcUf4m8uZMpQ72JtzX2CYy3mOTtOlgcf4HH5Fa1MF8orP5RE30Y84WOJME1m+tP2k9
 ixURg4pI0KoR8hKFS/WULnAPo14wIrjToipJON5aKgSLczlwhNKB8LyM1jdu6P74XxoR
 60UQzS9lkXGGkwznIREG3k8R7QtcSasi2hpHgov4zgKjC26ugybieOLjOgQatFIJn/4p
 bhq6zqkndqdXU3LSfAOqyhAqiWMP66eT1jkYHVitm23k8Hc1I9udUUDgaVaPP/e26BqI
 owB8tDM59BFN9vXK4RLaOpadWVirDYrGMty5mUmHcQi64qwK2pYiXqXGn7ssoemB8Eei
 lDtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774969015; x=1775573815; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 b=UDQOpdOrkvuRJUSmQHNjfPMG/vNpot+0B9D7ggeK3qokrhIXTl74fm0KkaPGaFXDOr
 zlJxUw0eSBG/P9EOEv5GYToMd8tKmQWjCG/m2tcAAKL5sHcZay7qK1y6SgaU1z9q1UD2
 T9rrX4TxXscA+uLUop6ne/khJRcS/FteToVBvhLPn5nXvwJL0JafQt0lBfyVgkIrxtIk
 H7bs8WEcnWjJ2OCmFC2o4kGH92Bicj4InzjFBMLToTOs0XKG2s1VAS0WldofQElu0NOr
 7YAEBVEGncy57G55/Xoep65hHa/DxjO3YGgo98OHlcR13CC5esU+cFqBNjwQuBipie8k
 lpvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774969015; x=1775573815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ANeukgXaFkO22KK2P8lUGEhokznHH/pS+8BuIXKDR9E=;
 b=p8fXIZegUYP6Ik2IwQPlIgLmJkTT+VX6x7KHf5sREhevOyomW5ByKmZ2eMpSM5TXeP
 opoy097suy+b+VE4AqX7VYKycHVHjKTILJN5U0BIaVoU7homj+YAVbXhNLEehrzrT8+F
 BpmDpV/ZNi0ea3UBloeU9p8OxpTZFrxMXjoV8R9o0hewL+EA1QbRysct6xv6uOJ1UZJN
 XZNsQ50Aw5TPfdhPYf8K6am6QdFe4AFSyHSzoNgqk7NY2DETq6C2ZBXUeooe7CK+K6SG
 Ul31FQk9iYkA5MyrRmc1gqq7Ixh8V2Tzyypf6z73nCb7lcXIfIiMLfV8mxKa1WzoR5eo
 wekA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbZdQ7/4Jb+kdWhIZF0CWdTVbHm7r+kRNR9aa+DQsNsqaaak6zBFImM6Jw+pp1A9nkNBv+y0Mm@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9gQku5CsHOYQiTLCQh5knKo0PrQ8yodJA/fUvvNb9hiMnM8Gg
 tGSAVmEPmb0g+XISq0CSRrT7NG1eAUqNIcvTWIybw3pB8Uce9Ovwcj3jv+ge/W4Bx1jkCLRZWNO
 BP6Cz9PJ4QljxMm2FLGOYoh38gbSvZjiczQbZVBbParUevnjlPaXE/is=
X-Gm-Gg: ATEYQzxt4ajQQ9SwdLyfePq2Wg1y1fRyXu9EP7ajOZoR7LipKO36dTe3hAjCM5/2Gxx
 SYwnXPh6wkmA6k6q8LxkLVOZMrpnsqvWxl3UU7fvGeotbcCBfwHz24bEv7x1SpuiAFjex2q6b8d
 KL83xb0JnFPZwpBF1AWmT0a8EmIWynK4aAMeXFrJOsVlQKRvlhESgs4ncsDh7xl6JXrrzAluR/D
 2+aekRvr2kNLWLj4ACM8Y7x6RutYgKNr/Bmxksx5xmCpXUTttBCZFTA4iCeTMiTuUmCyZgrSpmk
 Xmss10KXrmZndZOoW/3M8fkBc3FWamz3DUT56NrD
X-Received: by 2002:a05:6512:1088:b0:5a2:a13e:9095 with SMTP id
 2adb3069b0e04-5a2ab5ff25emr7387493e87.9.1774969015482; Tue, 31 Mar 2026
 07:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20251224144708.61167-1-marco.crivellari@suse.com>
 <20251224144708.61167-2-marco.crivellari@suse.com>
 <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
In-Reply-To: <CADnq5_NJFv=xEyN+VQOvt=7QifK2rFUcKru92YAeX+2m-9PSNw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 31 Mar 2026 16:56:43 +0200
X-Gm-Features: AQROBzBVA_D1iAW-Kp85UaH1G04gvnNXlDENnGgd1wdQCpwHDZgCRMm0f50Wzfg
Message-ID: <CAAofZF4cmrZFFiMnxFh+LEc5b4WF3VQ1z7GXaeqovK9UU_H1Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] drm/amdgpu: replace use of system_unbound_wq with
 system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philip Yang <yangp@amd.com>
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

On Tue, Mar 31, 2026 at 4:55=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> Applied the series.  Thanks!
>
> Alex

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer
