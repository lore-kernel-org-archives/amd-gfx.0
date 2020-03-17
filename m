Return-Path: <SRS0=ZDaT=5C=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B0AC1975A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 22:24:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A82E206EC
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2020 22:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWVEVdXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A82E206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480BA6E822;
	Tue, 17 Mar 2020 22:24:54 +0000 (UTC)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C5289CDE
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 21:55:29 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id o127so10322092iof.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2020 14:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=evRm5FnIsFv5bYsj6rH8bVKtBD98a92L4fhTV0KkCFQ=;
 b=jWVEVdXohM9ysZy7Qgj5sqfAV/ACH/UoLDnanrCRAN3jOda6KBLO7zbeP7G+vV2KwJ
 m7zxPCmTUoFozR3vIrZ4J9uwhlIesNIU4YPPjCkzfv8y/i0R8H0wZLdZflhV3KvrKGMM
 KI+1HDZq6F2ZHtb6eYY0SNjYqdfChApa9dMUSSp7GYT0hWWNo6d/Dg0XMYwEojP5zA5f
 PjCeh6JdvsSIqc9bDVjQx+Tw/VYCb91BA7XaXvdBlXDfCO+/DOuoYs5CQofoGfaFp0Uh
 9oaocC+7Aifu2gTtabVOA5A0f2BpY56RT352VU9turvcdFWe+hwqJAp9y4CGupOiWb8x
 pb1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=evRm5FnIsFv5bYsj6rH8bVKtBD98a92L4fhTV0KkCFQ=;
 b=oSbRDzmYU0A6dsLTpZXyeD8fSRGgVOO9VM9ZofiXw8VudU4P/Gqemu38+PzGwo0XWI
 nqCw0JisE3r8LRHgKg33VfiNbNaxJVAmr6xdVIyfjxTAW+5T3qEcqHgV5NqxWizU/+3g
 WSTUkkkYEEJBx1vHhi3kiFuFzio7uU13cPomAel3KUuVruv9A4eBnOVOWN25kuJz5kA2
 XoE6urTciH4s09KU+MQkKayP8d5GCpzDJQ5+Hn75PG8TjJs4Gj+MSasMm4x/0/40lwH4
 jWupZaHALDdSHGph1DoN41DcGoRUA9Pohw7J+ytpGVPpFhpNtrWoEi6n6bHTV8VIk2QV
 t8vw==
X-Gm-Message-State: ANhLgQ0MEf/8T9G6y/Mf5U3hv+cMjmvtknlZvG1aO2ka+grZHjN/DHM/
 Ryh17dBElOZmuQ1HDeGxE8iFURE68OqP5nRvRap5hxJh
X-Google-Smtp-Source: ADFU+vtWpiZPH5/28ISEa5ZcoS0NMNbTeSr24qoWBZsMgHXnO/10/CKPhhp7VbbmhYWHj2aXpxWwD6rqrHqEPSmNbc4=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr898617iol.106.1584482128705;
 Tue, 17 Mar 2020 14:55:28 -0700 (PDT)
MIME-Version: 1.0
From: Tristan Vroom <tristan.a.vroom@gmail.com>
Date: Tue, 17 Mar 2020 17:55:23 -0400
Message-ID: <CAETxV2a+OdyQ_tB0jFHA6n1Ci7kPH6ATBSuHNo4Uq_AuZEFEqg@mail.gmail.com>
Subject: amdgpu kernel oops?
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Tue, 17 Mar 2020 22:24:53 +0000
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
Content-Type: multipart/mixed; boundary="===============1097110556=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1097110556==
Content-Type: multipart/alternative; boundary="0000000000006f3b6405a113fe52"

--0000000000006f3b6405a113fe52
Content-Type: text/plain; charset="UTF-8"

I don't have a lot of experience reading kernel logs, so I apologize if I
misread something, but it seems like I'm having some trouble with amdgpu in
kernel 5.5.9.

Here's the gist of the bug
<https://gist.github.com/WindfallProphet/6fc5135774a1c5d350742f013330e5e8>.

Thank you for your help.

Tristan

--0000000000006f3b6405a113fe52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I don&#39;t have a lot of experience reading kernel logs, =
so I apologize if I misread something, but it seems like I&#39;m having som=
e trouble with amdgpu in kernel 5.5.9.=C2=A0<div><br></div><div>Here&#39;s =
the <a href=3D"https://gist.github.com/WindfallProphet/6fc5135774a1c5d35074=
2f013330e5e8">gist of the bug</a>.</div><div><br></div><div>Thank you for y=
our help.</div><div><br></div><div>Tristan</div></div>

--0000000000006f3b6405a113fe52--

--===============1097110556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1097110556==--
