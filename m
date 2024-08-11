Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47F69C3DA4A
	for <amd-gfx@archiver.kernel.org>; Sun, 11 Aug 2024 20:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F70189954;
	Sun, 11 Aug 2024 20:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFkBO8I2";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A99310E064
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Aug 2024 20:45:27 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso4114105a12.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Aug 2024 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723409125; x=1724013925; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OF9G8PHTIC2mhYOq/Km4bS0ibPrNmYJrVvBjRIcw78A=;
 b=GFkBO8I2SAo9Ea72j+3YOI7+OUnpO78FPUg/cb65Nrfziawmqrcerjw7J186EB7Ltr
 r/nIHBuRs8u4mOrRyCF/dFCdhvk6uYoeSOq1KW6eXwe1ykd+eOfahUnizJsyd6Z3H558
 oZDszNysartho2OQki0wvEoTP/W7FQ6ol5+i7AU9/ccakh8saOQNxJprGsl3NR0Eqq9U
 g4vy8nFOmiUYBKBSxfEDmboVPgsbcQ42mUlTb1YC6lx5qcXqHTRluoa7S9N3xOsI+hmp
 BUB+QXtvUdRW1tzmtiCVZgU7ZxqwWDszE1P0dPgh+lwL4X73cQt7B0hPlFumtZR6kmdZ
 qGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723409125; x=1724013925;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OF9G8PHTIC2mhYOq/Km4bS0ibPrNmYJrVvBjRIcw78A=;
 b=fzKJXJVAMGNSnLyjRu/YnHrRsO/EMPcP9P+BdeXnEX4VUw87vA7S5ZM/6fvKkifRmW
 Mq2I99UyfikievH4y7ky7WmQ2tkQ9FA5355+9PN7Icxb4l0b6VDAMtdKM3Bzbys7pdMk
 DWBeFBr1TrXfvafI6fVBNFf4OLak4MGZEok6OhR+jJPGpIrGfaHmyUClNhXL0oOKDm65
 TMR8W1RdRtxCOTeBUlq/K6vEEQZsv6HOZjzXR1o28ZhWE/5FZzKNrG9PqzJjipAvWvU3
 blCycEMspIyJfcIURlMFPaVV9AyQFgZny+hbfcSeQm5pqHyRQrG4DJkEjHO80cMxl0ZB
 I3Ag==
X-Gm-Message-State: AOJu0YxAj5WyTSPXSmw3vGCjUlMOcrWCcWhL4ZDHtBH52twaAqzqLhCH
 rSxqAaMMNPcw/OZHrtuEqx/vP4hgw7vXEjvKA/J9RMr+uPJWjBRvUkWXXP0PsYeTuC5/Uc+o+R+
 maTX+xBk0uEaoAs5URdSJZki3XWSFE2yR
X-Google-Smtp-Source: AGHT+IGAFi4SXC8esHuAsPLZFN4TFag+AXUJzfSxbZb1QfPdBVYNYWWxqxKvrSJ/j7mmgirB2uhas7T5Drl6Nzm3Lmg=
X-Received: by 2002:a17:907:3d8b:b0:a7a:a46e:dc39 with SMTP id
 a640c23a62f3a-a80aa15e66fmr558901766b.0.1723409125093; Sun, 11 Aug 2024
 13:45:25 -0700 (PDT)
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Sun, 11 Aug 2024 21:44:48 +0100
Message-ID: <CAAMvbhETDhbHcTWxnsNOjnQwy+nygovDxjMj1iYOCFXwtpO4xw@mail.gmail.com>
Subject: amdgpu debug
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I wish to debug the amdgpu driver with regards to plugging and
unplugging display port cables and screens.
So, I would like to see the plug/unplug events, the negotiation of
link parameters: swing / pre-emphasis.
I have a display that is not sensed on a particular laptop running
Linux with the amdgpu driver, whereas the same display and cable works
fine on a different laptop with an intel GPU.
I think there is a bug in the amdgpu driver, but I need some extra
debug output, but just for the plug/unplug/link negotiation.
Please can someone point me to which debug variable to tweak to get
the debug messages I need, without being flooded with too many
messages.

Kind Regards

James
