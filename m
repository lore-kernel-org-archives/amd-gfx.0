Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51A1C5DF74
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C9C10E7FC;
	Mon, 17 Aug 2026 14:18:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PRVApgpN";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1C7310E7FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:18:06 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-5bf88d3fc8fso111856e0c.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 07:18:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976286; cv=none;
 d=google.com; s=arc-20260327;
 b=G0/uwMfkc8HDXworVDjpUJAKBUXl9uXZLTV8p11JmvGydWQMLSdhNs49mV4AUxlK5k
 DBMdSd+IJqeorLGm8JOk/NpR/VOR3Hh7eYFiX8M+qd9cjEXDA2EMjrB9NI9mQriWpP0L
 hfRFssCqcZnBzuONlqKY7jc7CgR6nVSlRwyuIABvQLjXh33m9vvvYSN2Jo2PV5ZXnC4Z
 FTmU6nz0Zq/vNQGWaUeVWqKPS2DlWUXN2Tj17ugFEQYsJzcV0w4s/N0y8O84RKLYRqSI
 EeyXGfII7bi/BFCVrWvLCVqu+U+XuZeCXRDQ3aOX7S3nXJDNXeJ4D+LxpYnqQQ0FznxX
 PQfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fJiC7+cQ8AtTWZU1xCie2iTw8hw0/psRuoPzVHT7FvQ=;
 fh=YOInKe7fHU6KQqWbI1KmabGU6SXgNJV4IZdJ367vBio=;
 b=RJST50cGOLOI0ZqpQANFXTEXFiUIr0LUZ52sGvTefAXiKyC0nQsCRT7FQ5YFPTaYjr
 wCX6ADMrHBgcM9MVxHYcg3KxV4/VPGqW1hhu7+74jVAq0V0VXB/n6eS2NDO8MsTn4ZRX
 FdFEagb9KGQF/E9WXXJK0aSb/3LGKLpKJxmeKLc6TuiX8lQ/wBxamBxHRdVzZrvSl3Ar
 3kEDsZPhImAblbqbk2bKqNCZaOHHr9Nonz5O2NCw9LwVSxlr+TNHiVROAk7KdPSVqNi+
 miKCZZqtrW9oIh/+jpSF/E2UFH1WvIPW17CrZdew2SJPksJQ0eW1l0KP9qJKjwp5p1iJ
 /jWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786976286; x=1787581086; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fJiC7+cQ8AtTWZU1xCie2iTw8hw0/psRuoPzVHT7FvQ=;
 b=PRVApgpNXlJ/LikALGZAH0mybF6oknhE+C9D45eFTYIhc3e9YUJmZEBsTG0RDHJwtC
 tR9Exk5uqyX7OArA+eWn8sHzM+2zOEDzkNpE0j7VrpPj4ItDVSMINJWGbIrZnsVMVD1L
 aK/kianK8A80UfzSlRcc//OL+Fu19MHPi1Phfbk3NSGWRl7q0wnHQ9Ew/UbAhaBxkgN0
 zGoN1j20qr8aC9glWi13L/X+res1m9+eFcesDdedGudF9kGXj3XP3HstsAN9r/K7gb0T
 wCCNk+cmiAJ+bEA/GJLvMw7WCTRVrAshXsGw4tIRxmdh2hjqOz/liniN289ytwkW5sf0
 UImw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976286; x=1787581086;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fJiC7+cQ8AtTWZU1xCie2iTw8hw0/psRuoPzVHT7FvQ=;
 b=B4jRcJyxNLsLnZAP9QxggWZFFrwzgfHYDynf/HdfaPo6sWaeT9+p/dXOnuJGKGB+zs
 qbFe9e54qWm6rUCZlfNK49ebbIYF6S+McSsk7s/auVehvfhUdL05ZzgyZ9dbL9XD25dw
 vqUKH+l+h4a7EaRF4nVmZHDZWYQpXwQ6RnHhGJSrDqgE6R4R2BupbXWmhXCgqYGjkVTZ
 oNehn/VpTvNP0ZrhErWwxS33JaDSe5heN9nEr6oottPcG2RmxmneDhNQclEnw1MHLVUw
 ADgsuGEZOjZshnp4mD58RduNQYWEzL1yRX4rwMGD5Fd0BfQYG23k3GDpku9O5LaaU7LC
 AatQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RonRC6/mFsr3vSM5VJeGDQFBLajpz1+NndtMnm9qI+bFiHSPHDF/6rEZoDQovd592puv/uF0kf1@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhbUd0jUNdYdqD/qolI47aGpNG18m8VnVY15Ixjlg0l/JyOhhR
 +3lZBmh3XNpCaghaDitSEBxEOgmoy9NRuEcoGvekrdPzb/v/Qj0+yeZN2IQ7FFqCVnFWrV+XKfI
 reH79K80ytr2qhvlBHDQEYUWLYB/SQl8=
X-Gm-Gg: AR+sD131OK/LVVuENybFXU7nNH6xGyucC5H0i9U11ACpu64rdAcqpv/1C8ZWX+5+n3L
 JrEa9RuTER2Oeeie78K2xtaNY/oVjkGPWzYQDKCwGdt1fTqmvd1VqJAnF/gS+/TSoKoGs5RLUqX
 y8Y2WM9aFgcN1fAy/CcVWNnA+NDWDCQb6REb/2APZXY8L2rqLcHqx9by+IFWx/UaSrOVSuawK8v
 dLpAp/xMY+3IuLlDkxtcOhSRZBQqjzD8eHZGSceVvlL9UjjitMD03I/jsZJigCUlLJEc/5RgJ34
 AFKqSbDKnB8TsxQx1wDLIV/3JAojHzIIDi8bqpwe+URj/OT2sUpsQLDltX1VWvhZznny24tau/2
 DQRqv8XDfwiPTvj1iBTGxR18Z71NJ1Lo=
X-Received: by 2002:a05:6123:4205:20b0:5c3:6e8a:4a22 with SMTP id
 71dfb90a1353d-5c591f2c4afmr1542021e0c.3.1786976285747; Mon, 17 Aug 2026
 07:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260816172608.14470-1-Priya.Hosur@amd.com>
 <59918fde-87c3-434a-a606-abb11ab3d899@amd.com>
In-Reply-To: <59918fde-87c3-434a-a606-abb11ab3d899@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 10:17:52 -0400
X-Gm-Features: AcwNN1UNEHZostKNNw_muonEXPSbkFa9jKBeiut7_q3ahxb7znFNkopjnr98fFY
Message-ID: <CADnq5_O+qrWfFiLoMtdjFzXm2x35QK5ZFYgqX98qepXkfP2HGQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/1] drm/amdkfd: Add TLB flush after MES queue
 eviction/suspension
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Priya Hosur <Priya.Hosur@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alexander.Deucher@amd.com, Sunil.Khatri@amd.com, Felix.Kuehling@amd.com, 
 Shaoyun.Liu@amd.com, Mario.Limonciello@amd.com, Christian.Koenig@amd.com, 
 Pratik.Vishwakarma@amd.com, Veerabadhran.Gopalakrishnan@amd.com
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

On Mon, Aug 17, 2026 at 4:07=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 16-Aug-26 10:56 PM, Priya Hosur wrote:
> > This patch adds heavy-weight TLB flush after MES queue eviction/suspens=
ion
> > to fix SVM page migration hangs on gfx1151 with XNACK mode enabled.
> >
> > v4:
> >    - Dropped userq TLB flush patch per Felix/Lijo feedback: TLB flush i=
s only
> >      needed after batch unmap in amdgpu_userq_unmap_all(), not per-queu=
e unmap
> >
>
> Sorry, that was not the intention. I was thinking there is a unmap_all
> API in MES in which case this could be done within FW itself instead.
>

There is a suspend_all and I believe the reset detect and
detect_and_reset calls end up suspending all queues the type specified
(gfx, compute, sdma).

> I believe Alex was also asking to check about batch unmap cases of user
> queue. Ex: - amdgpu_eviction_fence_suspend_worker there could still be
> inflight transactions similar to KFD case.

RIght.  When we evict a KGD userq process, we evict all of the queues
for that GPU VM.

Alex

>
> Thanks,
> Lijo
>
> > v3:
> >    - Split into 2 patches per Alex's review
> >    - Added userq TLB flush in amdgpu_userq_unmap_helper() (amdgpu_userq=
.c)
> >
> > v2:
> >    - Removed "SDMA" from comment as this affects all in-flight memory
> >      accesses, not just SDMA (Felix Kuehling)
> >    - Added Reviewed-by tag
> >
> > Priya Hosur (1):
> >    drm/amdkfd: Add TLB flush after MES queue eviction/suspension
> >
> >   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
>
