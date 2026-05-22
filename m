Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E70CD4F3D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 08:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C52210E669;
	Fri, 22 May 2026 08:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H08HdUBu";
	dkim-atps=neutral
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F1B710E1B6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 08:31:36 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 46e09a7af769-7e363c6141dso5928840a34.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 01:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779438696; cv=none;
 d=google.com; s=arc-20240605;
 b=b9Iro1BPg+LpJEuPKRCjiGPUtT3BPldeinFdIVGVBZ1SfLd03MzyEIPvwkYBYpcGnL
 zA8oRSKU//ZG49WQa39FCTqIH/zu7zs9gmn1g+ojw+tEDG3VJCS9eqe5GXoJGAe4fVFt
 et9MYsAgxYSBcLUUdwWpih6RaIjDx9XncNDkIEMHVS/lO/nSAeeoI/MXXicc94KKxC8k
 hCRtknubLjzVuaZSNQD6BETKCRTO/Lsz/96B+HAQZT+NsgsUaVtmFWFnrxNocG6IXCjl
 AfI2uwGqXIA7CV+OAdfyVVNdAjVVmNoHZQ99rdKuFZiOlW2Xm9dcza290hZ8XjFjzncz
 dj3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 fh=K4oB6c8XPSePsU9WBhEA0mcpKBxSUVlntn+/DekCnfQ=;
 b=YiRvuymTaiNKPdugKe3m9a5a8Qsd3w2YImFY9SKS/ygrwrPQws/hqGz1MDGnyO1eLO
 pkjotolHB8bkKNJCdZ6dFD1QFrTXhV8Yn340MQtg3ZnQcOlw5vSs9AYG4EXgzFNQLs7c
 8vJdoEvbek4PV3R1FFz5U4Nd6ejDK19C0acZQ1eIpcMwdL+nij7SPcjpYqkJ+N5jAzdu
 /iDrQl6IVV91ZkZn32ReBDtjfZzJsnDjzDh3n9PmoZ9DqIp0EkfYzjAOQCONTxtLxEX4
 jl+4twiDPxSZaqUf6SXa9C86ELE6zhR8pT0P1PuaSEE/nEEuoLzHVZeUb1YXEDFTyaWP
 UUSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779438696; x=1780043496; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 b=H08HdUBuwu46VvkyPvPg+b68rk6rGandYdFqq0c3AIBmcg8W2Vz0fX0OfH7snP3B/w
 Pmng3OdGQ8or8K709Bk3nafh7I8X/u16Ymfay5J4peN5vibd4S7/drGU7S2c7GoE+OZI
 cYIVkk8eXTlXMXV/au6hO4HcMcw4cI1XOVy8/TAIpUwVhgBDXbl/JQYw7XhMwcKq7Ewj
 rVuMBKudUF9BepjdZD88GgLwQBmZFuXPyy6OXzM+c5YW48n9YYwnr0scgBLNoX2M142g
 z9+/mIb/Non3vlBSAcySIo1BnQt3+kymY2TI//zvzkX6w9a2AkJ0FlupckLChkpsYR2J
 bO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779438696; x=1780043496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9ThiWo7n+RoKO5Fmewf5eOm/6gdGdTn6HMevgFDP/mU=;
 b=QlrXmVzF2KX/LVtqTEiy/Yuh/XhSETjZNQCL2AAALGWAbyyJDnwB8ktOa0knAmg1lj
 2ONACb2fz+mexABWhh5xAzO/W4wp2iN7qMdOqefgBaJMs3bOmcbXrctXAQ6rDh/kHHOV
 vu6Wo8Tytkm4Mtrzr3G9sVJusWJJI44/F0rVT+43id/vsud3C228RYZcvJXnYZA/bprJ
 ce1XUMO8cKYo+Kr2d5C6qCUUJylvEU7Q4K5rRRaqPRlKT+mKoWhBZAr6wea7pGkQZ0u7
 t9J72SF46hg09nYFmuZZAm9XoFPZSOwLjA2f9eN4fldh9MDGw0Nrmr8MKhNvyDzGebAu
 bqJQ==
X-Gm-Message-State: AOJu0YzrwbPA+6JUHC5+NhJo4vKdzE1V9l9xBnI+gPmzc7VY3+ZoDWOW
 2E5KsUZCspPLZq+KCMi115t3uhxgyEG4qmLEnwdHFOqDbxNoDWEN5S6AhWdxrfciILeHtPEIIai
 SHeVyh5ObsVTdXu1bPH45DE2oGZ57H/8=
X-Gm-Gg: Acq92OGWrRYHKigSs8FdJoZExdSld4np9isyJ/iAkl4nPJLY6HDH0xTGXEF4xbGakjl
 gu+BrhKXQ3/Cx43Y0X5c6wQOa2t9KC0R4rgBgEwcSSs7lfKJmnJzM4PXD/CaW+8TSD6LPtrKyRS
 +JYQWpo7ex+D6A+xlKyZFujdmFgj2TP5OoxAsY0o1KqPgAF3xF5F9oChnWApotBdTy0NOI9j4bF
 E3GCnqqYuQSVy1iSXdU85al8f6pU1y0SuGlGHZvHAtLwTDBcMs3znVfwufQGrEpeC3tq64q7m5y
 bkskEqDsog==
X-Received: by 2002:a05:6830:4707:b0:7d7:570b:6800 with SMTP id
 46e09a7af769-7e5feef54dbmr1560827a34.23.1779438695670; Fri, 22 May 2026
 01:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260521104335.28978-1-mikhail.v.gavrilov@gmail.com>
 <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
 <20260521150841.20625-3-mikhail.v.gavrilov@gmail.com>
 <55aee3e4-9003-4694-b0fa-277a8c2bbbc4@amd.com>
In-Reply-To: <55aee3e4-9003-4694-b0fa-277a8c2bbbc4@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 22 May 2026 13:31:23 +0500
X-Gm-Features: AVHnY4LSbTM-4tTWAVOgrISJCrLtgJ-GyODBgDohHuk9RVR7oadaYTWLeSuLNrM
Message-ID: <CABXGCsPPY3qX7Ad-a7==nmA5R7aejCTCrmWYpn-9OQQU=1eMMA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drm/amdgpu: fix recursive ww_mutex acquire in
 amdgpu_devcoredump_format
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
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

Thanks for the review. v6 will:

 - trim the commit message: drop the reproducer paragraph, keep just
   the problem description and the solution
 - move the IB dumping into its own function
 - replace the break-based flow inside drm_exec_until_all_locked() with
   goto error handling, and drop the now-superfluous `locked` variable
 - not call drm_exec_fini() in the locking helper on the error path

One thing I'd like to confirm before respinning =E2=80=94 the !mapping case=
 in
the locking loop:

mapping =3D amdgpu_vm_bo_lookup_mapping(vm, pfn);
if (!mapping)
    continue;

You commented "That's also an error, it could be that we just want to
print the IB start address in that case."

My reading: a missing mapping is not fatal to the whole dump. For that
IB there is simply nothing to lock, so the locking loop should move on
to the next IB, and the content loop then still emits the
"IB #N 0x<addr> <dw>" header with no body (it already does this via
goto output_ib_content). The dump continues for the remaining IBs.

So in the locking loop I'd keep `continue` for !mapping, and reserve
goto-abort only for real errors (drm_exec_lock_obj() failure, VM not
found). Is that what you intended, or should a missing mapping abort
the whole IB dump?

--=20
Thanks,
Mike.
