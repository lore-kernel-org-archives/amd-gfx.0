Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBACC4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56A1A10E0D5;
	Sun, 12 Nov 2023 18:01:12 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4052410E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 23:32:56 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-32f7bd27c2aso1683122f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699659174; x=1700263974; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=HpQQWTdBqHFTmJNUoiy1oT/yZ78ycZkY/c+sOqBhWe8=;
 b=SkuASrkdMEbSZOgAZ1TxHv8ife0Vp5gmDOU3HSezFOgtYlGKAgbKqSrGMsid7kIshu
 +5M8ZgoS8wdRSSdXJE9cxW6titzQeZ+oF+Spe20yrvhixROOw9mIyAzVX4eHXZ2Gozqf
 a2wmNG/D1Fq5O3XkNdNJAp8VzQ+UTwVkU4LFLbvTHq+L9lc/chU1xhDoHsonyuVq0QGz
 pwLaVS7xkayCUSKJ3//BeFCBSxVMqGEOnt1DDI6uGr4OUEgpMEv9WMuyvDJzsWfBpSEa
 Mg5gz3qBZjSO5YWIoV8ydKj6I04A4rFyP/FxWq9F86soU7++sKcQAzIkIW6vGyXyoYUM
 pRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699659174; x=1700263974;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HpQQWTdBqHFTmJNUoiy1oT/yZ78ycZkY/c+sOqBhWe8=;
 b=Lj7mFUtCWKeS/hz7ECsjkcTN64Llhy2rJX3x2fxvmBDn5fmVsiVqr3MiZZl0xKqBlo
 h1QMDXe7WlTFjJ3t9/hU2HZ9opKR11kjJKhsr3/BiD5EZdFB+/C7O1+Tuhws9x9LrGUV
 cB+VjlEX53iS63wsv21dxHvSTycBrO7PW1TUraleDAsf/Hd+PTuEFJEnmk7jZFmAnj3L
 Nb6vESfWSY3CF44vmHZKglOdrq98pCO+qOQA6GKdsw2NeFmt+n8Fy5VzUu7/D7d3eQW5
 sys40djkov7X+qgbiZNpN6womDVt/FfXOvkaJIosYYaN+3dPmrG2WUzbCt+FOgFoylaY
 PAuw==
X-Gm-Message-State: AOJu0YyuUQQfqtsy7SpX/9ItwriWQaNXyyxBIdQkY5pIZAGKbXVVP9/P
 vkHXeJ50YE0oxwMcfdzwbzk95KljRdUWWBMDFFdixcX/8bp6mDTR
X-Google-Smtp-Source: AGHT+IFSv0SRci0nz3+D4ShjG9cVywVZyzHs8uOz55coeo5oYeugzp56ZZwOYFUPdULmabKlWz7PxbIHtBVqiWcAGJE=
X-Received: by 2002:adf:fccd:0:b0:32d:5cc0:2f0c with SMTP id
 f13-20020adffccd000000b0032d5cc02f0cmr473702wrs.40.1699659174408; Fri, 10 Nov
 2023 15:32:54 -0800 (PST)
MIME-Version: 1.0
From: J Fra <jfra4799@gmail.com>
Date: Fri, 10 Nov 2023 17:32:43 -0600
Message-ID: <CAE584xaTsBzyJ1kEzJJwPV+=7RVr3CX45VVHGoWujYHsdgwe7A@mail.gmail.com>
Subject: Re: [PATCH v7d 04/23] dyndbg: replace classmap list with a vector
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000005476700609d4bd00"
X-Mailman-Approved-At: Sun, 12 Nov 2023 18:01:09 +0000
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

--0000000000005476700609d4bd00
Content-Type: text/plain; charset="UTF-8"



--0000000000005476700609d4bd00
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--0000000000005476700609d4bd00--
