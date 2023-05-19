Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D9FC77B7F
	for <amd-gfx@archiver.kernel.org>; Sat, 20 May 2023 10:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A82A410E009;
	Sat, 20 May 2023 10:46:13 +0000 (UTC)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23DF410E0E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 22:36:51 +0000 (UTC)
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-563874afe98so13945927b3.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 15:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684535809; x=1687127809;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1pUr/Z0Pd2QEFpItO8zoqnICWeOFa5wIxnpFbsVSXqE=;
 b=R6WIloZDquxkRATxXMyRAsgkJIBGLgdhndveoBrtX886UIEqGtTWLbt0NS/qE2lNb0
 OFRyjg/2dIYg9LDf7lnEDeQl553h47NeiZFzsWbVyHKOvIE8oHYFc0e1WGl0ldbmLdwJ
 6IUW96fZvrW2gtTTfokep3OH5kGKGyykPjStUVGv+nw4pxyzn8D7oToBXNMrB/Y/H9Bg
 +kLOkeeHdBsUyiGdAJM4PaavashkCZwb8CkhYJK/TXd9Wa1D8bBoyy5yfdC2NbpsiUGd
 luPEFua4aTzyg5lNQuSjSGA/g7FhyZjR69Ccx51E0wU2wORAPVr9dSeQMGDwcguyKQ+b
 nk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684535809; x=1687127809;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1pUr/Z0Pd2QEFpItO8zoqnICWeOFa5wIxnpFbsVSXqE=;
 b=Dmtj+WVMvZl81P0Qb3BUtvE2A92bb2PdJ3YTlEscfLGs4GqY9FkpRc8tk3V/aksE9x
 p7QawetIf8MNyoJOPFObd7ndQYggGSUqr6CNL/46MKJJCWEXFaghzXDQTMMMyyoBep53
 quZ180DNok4DorlV0Vr5g/rT4LeKMMVhYp/YO5cL8uIJStVYtoM29yFg3/tq0h2kuNi7
 BzxxtG2J9/DL9VD/U2bs6iq6wajjKDyL9uy+nkaPGltnv7Pz8YL6W8GR9IQZ2jujDD7N
 i1lpDLRJgfE1EbjcgAgGATqRtNiARrd//C7M0uxkB4wL7pzO8cbeUAJEFMsLqd6PHYwZ
 BIOQ==
X-Gm-Message-State: AC+VfDyAbm8MwVJ/ndaXG7wg9mXV7SvSoDXS2yrAFnO6+qFFviIwDT9c
 lwik6N14gAraKLQanbPhpE11qsbYbVnuyBP8WVSwQ1wYQyE=
X-Google-Smtp-Source: ACHHUZ58C7oD8fMAAO2VvjYxB4n3YziNyqkYNqOPj0raOEym1wXX6Ac6xmZbjJYByGEYeyCnGaBWh1wFfzV2Z0IJeAY=
X-Received: by 2002:a81:8351:0:b0:559:f029:992d with SMTP id
 t78-20020a818351000000b00559f029992dmr3759997ywf.24.1684535809285; Fri, 19
 May 2023 15:36:49 -0700 (PDT)
MIME-Version: 1.0
From: Neil Sikka <neilsikka@gmail.com>
Date: Fri, 19 May 2023 18:36:38 -0400
Message-ID: <CAHPMNWdWaYyQs1u=r7wt=DudxoogCOe3GL2J1UC-Gcdroa=MaA@mail.gmail.com>
Subject: Radeon Driver Crash
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Xinhui.Pan@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sat, 20 May 2023 10:46:12 +0000
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

Hello, I just filed a bug for the Radeon driver crashing:
https://bugzilla.kernel.org/show_bug.cgi?id=217464

It looks similar to this bug
(https://bugzilla.kernel.org/show_bug.cgi?id=198669) because they are
both locking up the GPU and the page fault address is at the same page
offset of 0xffc, which might mean its the same structure member that
is being dereferenced (or an underflow), and the call stack is
similar.

Please let me know if you need any more information.

Thanks!

-- 
My Blog: http://www.neilscomputerblog.blogspot.com/
Twitter: @neilsikka
