Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C40D1CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 14:16:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2729310EBC8;
	Fri, 31 Oct 2025 14:16:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Wbrcvng8";
	dkim-atps=neutral
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com
 [209.85.167.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F8EB10EAD6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 09:01:34 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id
 2adb3069b0e04-592f5fe03dcso2027950e87.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 02:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761901293; x=1762506093; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sz8A+kt2c263JVWpwySRC4hb0MoNUZ2J+PKEPthLk9k=;
 b=Wbrcvng8vP2ulQMKRl6ssHR5V7IYN/4gjaieh9oSFLjvDaQoQZ1Qaw/WhOSW6EwovK
 CzsymA3TMK9qm+xm/lIVEYcUIsd0qIaT3xu3D+VUkbf0EGR+keIVtTMXAA+WdlkFLFjN
 /jwtPCBgpmQEEur6R5v2Myon23CiGCXebRjftpnHKGHzfksHxVQsIVB+PEQ30Omu4mNd
 31hIz5NjBy/CiLRqkgzj3IjLLYTbDF8XUnimg/H99znIAlviTl69cRFwLv1PeAGEIA35
 gKJt82sq2oEr+I+UF1hVJA0LurmBjQH/rviduEs4zOrg3TSVYOyITXu9yDMXhrqo8cz6
 C2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761901293; x=1762506093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sz8A+kt2c263JVWpwySRC4hb0MoNUZ2J+PKEPthLk9k=;
 b=Lgya3bi06+ZF44Es1aOG/85qrnUqCLJL5FytW0JJup3ZpjzAC1HbFxuOTWea6W5w/N
 /QqehB85116slL4ClBuoNKA/y7kSuNiFkg9c0AvhhwY0y/8/GzTr9A2N5MLz1EfaHpLJ
 uAprA9iEINthIix23j/ps4sBIvTd0TR3eJcTUPNyODMW09GBcEpEIUdZFTJSOjshJ8UH
 fUF31o1CLaAHqYRxNKdC5X2XP7TuTHtBbqS0cJwcfWszwpvTiiDaxE8ck7W8l/r/ng4S
 gk13gRaL0Zs4sq20q0U/wOa2n22DNFW1H0UDemZna8VZQ6Q0PARqurRZWUYXJ6hUAShG
 SdAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg7sBeAkgo4SAgAH4MHWGD/SocowU9b53xszQw6LsvKQwSMH3nfLxmljnIr+ScX4SuFJnglDsJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5SW07W5POuv1xghLwB3Jfk9u9IeNUEv03lDAu7oVLaywru95t
 i9igYIWshTyWJB5vYyjZCUVhCabewFay60UOGdOPKvLxneRzsoShdA0xa7hQ26iEVLxz1hjBdg5
 DNxmcR4yG5TBK7CUkzFqYNsm9ZMxfs2go8NWVSE8ftQ==
X-Gm-Gg: ASbGnctF/wSHjGK8xzzgPSrGIhHe2ScefMlOyW8a1DgqykYa782KB3uQ+WqGRbhrnHA
 q5tJOSMM5nw9+WSQwM4PaosQLD0aRdHvKg5n0/CQLLTWx3n/Rl0X+RoTUIkEYBp6Be+mk7eXGqW
 8BTLXJR0x2hX1f90p/ampfih2ADCK6/XcnduFQEmKnvKyqb9KtKPUXl8Fe6MiEv9dT7BtI8eCu2
 MP9OIvuYdKijB+GTh8TVCeA7I20cwJv3tSR1yAYR1LmFw1psk8I4WjWW7jCj7oK6uW1vA2mDm9I
 6rYxi2wPV07RtNc6PA==
X-Google-Smtp-Source: AGHT+IG6dDTmqgRndauEm3n43gUUTvbxoIAo8xjrG46WEWaGTmwuwaI0CaRln1vBjuRad9gGiPuvQ5vdbLdXcNS55e0=
X-Received: by 2002:a05:6512:3c93:b0:592:f9dd:8f28 with SMTP id
 2adb3069b0e04-5941d53e85amr990212e87.35.1761901292415; Fri, 31 Oct 2025
 02:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-3-marco.crivellari@suse.com>
 <34829993-a888-4f7c-a2c6-e87723644c3c@amd.com>
In-Reply-To: <34829993-a888-4f7c-a2c6-e87723644c3c@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Fri, 31 Oct 2025 10:01:21 +0100
X-Gm-Features: AWmQ_blyHKRMjIwqs9IEExJag89S5F7s8p2T3thDh3CMhSPUjI4-6H-ukHS_NTs
Message-ID: <CAAofZF5pSB-kJVr_PJbo_845VbpaB1Fbf+yeA74sWOU_vXfypQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/amdgpu: replace use of system_wq with
 system_percpu_wq
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 31 Oct 2025 14:16:25 +0000
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

On Thu, Oct 30, 2025 at 6:10=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>[...]
> In this particular use case we actually don't want the percpu wq.
>
> This can execute on any CPU except for the current one.
>
> Regards,
> Christian.
>
> >  exit:
> >       if (amdgpu_sriov_vf(adev)) {
>

Hi Christian,

like for the unbound workqueue also the system_percpu_wq is just a
rename for system_wq.
Technically I changed the workqueue because we added in the code two wq:
- system_percpu_wq
- system_dfl_wq

You can see the commits mentioned in the cover letter, shared also below:

- commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
- commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

So basically the behavior is the same.

But if it would be beneficial to have an unbound wq, I can send the v2
with the change!
We did so also for other subsystems.

Thanks!



--

Marco Crivellari

L3 Support Engineer, Technology & Product
