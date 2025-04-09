Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0690AC369A6
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 13:08:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BDD10E9A0;
	Thu, 10 Apr 2025 13:08:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WwF7PIVq";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38EC210E258
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 17:27:32 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso1220124966b.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 10:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1744219651; x=1744824451;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pK2SJRHEMGZQKPPhXQK2rlcnL3fUmvPRMjfdbeZZl1I=;
 b=WwF7PIVqv2Wqgl8vRkTs4ceEFKEw6lpnQxBnzHs0dEF7PgmgfA5xzvtkq6VuExHS8X
 QV9QA7AJGdoVeMbmKqDk+zGPauG0iR4f17qMDPOZJRm7W5BHDBziyE/AhLSpnqd094vc
 HiZqEpUaDXOZ0yj0H/fYlTDpG03DKEL4/ZwHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744219651; x=1744824451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pK2SJRHEMGZQKPPhXQK2rlcnL3fUmvPRMjfdbeZZl1I=;
 b=ECkvkGl/RNjsfifMv6YOhsmRG55OdA//VX3IDtaixBAPb71pvEEdbh1J6D0otANfdS
 I20aMEkHeR0xx6/r1EY7HUkBlhSooD4xCy2Zoy6LFIWR/ZsOQ+QUCmG7vulDkNAqFmMT
 036KfcBlUjbqAGzDf+qLSFvpga/qVHX+NEOdNc7aK4IllOgfjDmtOybiw9Y1V+MbD2Sz
 b7TfboQtLGpH/6z8p59tMWOW5IVaikxvfcuEua5kshw8iA9SO1QQ4zqDBee0jEWIqWz8
 NHe6i1Cyxx4TRVNTznk0BPMGF7VGiiXxFG1pq9y7UHxCngmVrRm2duAgonyfYTWg2tpr
 UTxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFdwrQM1WXZZ33jnqnMLTTaWHovcNGK40BG4ut1AG7xwP7G+IQ68cv+i9vVJrhjkJb8Wf50dfB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGCGKHzy68peXO6dCQUQaNDkKx/YVXdN0Bh90vXW6xWrhIYjov
 FADW7qa/hyYYvXbhKqbUgGez2Q3/84k0+/Cawrh5l8XTo93NxMg4iCO4I+rHZqtCRT54rYU5Zf+
 l4ls=
X-Gm-Gg: ASbGncsb+YjhkM6Q1SoqnsvR6j6zsB2eVGpS4WTYdmBJJxXq1wjq5R/QHASU5agdipi
 oHgvNsqwtDC3sjl8W6GRSfFY6SB58Ok3n9UcL/bDa0ShHVtDqwrTedrO/NESnY5a0qKH4P05weC
 8mrfvzPhSTjCPK+QGsjkRkPOZbDqck4pbvSceancwE8ligNUiWGwoFSH7XP6ts6hOPxcjBzlTET
 9XsmYdiGrlA0B5rrWMsNCCB/GEiG2D1/q+VTbBItDOG5Y2XzyfPb0cwFlB62mY+Sv80V83WW43c
 UKTVBW0c2u/Vk/z40GO3p/2Orp//vNOvaNriW7ISB+c3J0UTubHRSpkkBfFCPIYvAbNwo4jz+7y
 lp2RDG2Z0eAVHErg=
X-Google-Smtp-Source: AGHT+IGY0ozLwlRMiGMj61XwDURaoV2RC1bOrZCXWZ75Otz85DEsmDpP9DsFoV/mirWje3xwXawvUQ==
X-Received: by 2002:a17:907:2ce6:b0:ac7:37da:cd46 with SMTP id
 a640c23a62f3a-aca9b72f852mr339605466b.49.1744219651090; 
 Wed, 09 Apr 2025 10:27:31 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com.
 [209.85.218.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acaa1be8fd8sm127479966b.39.2025.04.09.10.27.30
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Apr 2025 10:27:30 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-ac41514a734so1224981366b.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 10:27:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWhnPTkEyvAOyN2X7DR5RCRuEjvQ7efl3Pr+xTG7kiJpYcIPdQXImZc4MC+tCe/y0ZQ1untTNEl@lists.freedesktop.org
X-Received: by 2002:a17:907:3e8c:b0:ac7:c59e:fc3e with SMTP id
 a640c23a62f3a-aca9b67684bmr382920066b.25.1744219649909; Wed, 09 Apr 2025
 10:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250408091755.10074-1-arefev@swemel.ru>
 <e6ccef21-3ca5-4b5a-b18a-3ba45859569c@amd.com>
 <bmdour3gw4tuwqgvvw764p4ot3nnltqm4e7n3edlbtpfazvp5c@cqe5dwgc66uy>
 <f8810b13-01d1-4615-b6e2-2e791c48b466@amd.com>
 <qc72y52kt7vuwox4lhk42zligy5bslttselfoexse42mywtpps@ebqijs2tap2t>
 <edc08eb4-63dd-402c-82df-af6898d499a9@amd.com>
 <pmby7iowvxuomsbuxebttosz245j7ngw5enbl72dq675nrgvve@ugkvzeihbtut>
 <CAHk-=whLixL8-iYt1qH0-YvEnVsYtryZaN5Da0qoBBhKsBnumw@mail.gmail.com>
 <437e12e2-ac0d-4a97-bd55-39ee03979526@amd.com>
In-Reply-To: <437e12e2-ac0d-4a97-bd55-39ee03979526@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 9 Apr 2025 10:27:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLQzkTTDwJ+ZdVdgNKMg958petkdsu-+m7s9UL6PVCRg@mail.gmail.com>
X-Gm-Features: ATxdqUGsb92LP0ScG527vuGNoNqzICJmAsHs4dqdA5fj_-LSDqiGYUn4VgwYYwc
Message-ID: <CAHk-=wjLQzkTTDwJ+ZdVdgNKMg958petkdsu-+m7s9UL6PVCRg@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH] drm/amdgpu: check a user-provided number of
 BOs in list
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>, Denis Arefev <arefev@swemel.ru>, 
 Alex Deucher <alexander.deucher@amd.com>, Simona Vetter <simona@ffwll.ch>, 
 lvc-project@linuxtesting.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 David Airlie <airlied@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 10 Apr 2025 13:08:15 +0000
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

On Wed, 9 Apr 2025 at 00:29, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> I mean open coding the limit checks everywhere certainly works, but as fa=
r as I can see it would be more defensive if we do that inside kvmalloc_arr=
ay().

No.

If we add some limit to kvmalloc_array(), I guarantee that people will
just then call it with ~0UL.

Making it all entirely pointless.

So thus the "kvmalloc_array() warns about unreasonable uses
unconditionally, at a limit that is high enough to be useful, and low
enough that the automated code randomization tools will hopefully
trigger it and find bad code that doesn't validate kernel input".

> BTW we have been running into the kvmalloc() check on valid use cases as =
well.

*IF* you do proper validation, you can just use the raw vmalloc()
interfaces by hand and avoid it all.

The VM layer allows larger allocations. But the "this is a simple
allocation, choose kmalloc or vmalloc automatically based on size"
helper says "you are being simple, I'm going to check your arguments
are actually sane".

So the drm code can easily have a function that validates the input
for your specific cases, and then you (a) don't need the helper
function that does the overflow protection and (b) don't want it.

But it should actually validate arguments for real sanity at that
point. Not just open-code kvmalloc() without the sanity check.

             Linus
