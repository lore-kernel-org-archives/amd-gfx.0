Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEB0AE77166
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 00:19:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680A610E29A;
	Wed,  4 Dec 2024 00:19:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j8IKGVWr";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E220710E29A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 00:19:07 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ef10b314e4so818089a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Dec 2024 16:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733271547; x=1733876347; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Y48B4a1gFIsxIE9Z7fjZlkSeKUjuUYakpQ6wvW8PHTQ=;
 b=j8IKGVWr5JcNldd4tUwcGkWNhPwGTKuxcCAtO/pnmG966ijpdO+UK4LsMEw5IatbX1
 uPCW/Jw6SJJhGrSTlQGFFCXJtvYRy7gsBXP7zUdx6PvS/wb8BFtLzTXLXRNiuqsyCSoF
 z+qMDaBZMnn1gqBED+7MAHzqE9CjwSAyGBE69HEJks6nNm+ED3FPRofBRMxBydBPPRcF
 Ln/EKkXj52B61jRK8ZWuE8h1U2m5CJcg1Vw5RdkxbbvbezpHmLMdYE30JJIEhlGPkRpU
 Q1ORhXslqsX+y3DcE9WTMjMSAL758d82lWa3uWe2yTKjokL3jjuJoi2G5EtpmrODWVvh
 ogZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733271547; x=1733876347;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y48B4a1gFIsxIE9Z7fjZlkSeKUjuUYakpQ6wvW8PHTQ=;
 b=Pd9wO3+3EZa0hV+nmdTzgc85yI1pajOTJoVXKI9qxuOqe6JfsA8idEL4RVL8gz22zS
 8ErH0BGSe7ar57m6LI8cHdyPnWOonsIyh5qZDTvV3RGIjBVsBQ83+3ueAvXTuW5vkz2/
 IvbN8YpYilH5+jArUt60yW31zXghZk6vCnGvD92Yj2OeL0Ru9r9bbnLlI4PpC9mU2uig
 PS5LGpXYAJZ4FMqhUbKPY4bpDf8KYO0TKdwwfRWt6+zOzOsdlZ76Eeu8mZe46zmHNyXe
 bK6a6Nyd6hFo4a7ZS1xxOhXniBUkCio5bWd522OjCU7WQSxcXfH/738v6dxizEE3VqMj
 69fQ==
X-Gm-Message-State: AOJu0Yzu5bHqUHE+xVyfkpqxa5+vhz5yLFhbECepO1mf9NQIC2zFeaoY
 ApQQJ0fdhbKGQdDhgbAvvG/b74S5iHBu8+51Gj/Kfu3GW32hzOwR4tVwpO5uwGCm0bjanmEzRK5
 +Bo1xS2+Wi0M3Cn4LrmNbn3S+aslFCwoveGo=
X-Gm-Gg: ASbGncuEVWmpbv2wDmr2wbEy4xtVNc+wgfKcml7U6myV94nVLWDcUa4Hej09HbbO1GN
 irWQZkp5WTTjbjzJ6daTVQ3O4zfUNMHK/
X-Google-Smtp-Source: AGHT+IEIu6q9l/DTvjvO3JPjVu7Z0YM8mOrItmhI9/7rvydry1sw0P9vnvnYAX9y8McT3y1alxKBoy7JA0EB+lkS3sw=
X-Received: by 2002:a17:90a:da87:b0:2ee:be78:f30f with SMTP id
 98e67ed59e1d1-2ef0120a469mr6854590a91.17.1733271546878; Tue, 03 Dec 2024
 16:19:06 -0800 (PST)
MIME-Version: 1.0
From: Emanuel Oliveira <emfolg@gmail.com>
Date: Tue, 3 Dec 2024 21:19:06 -0300
Message-ID: <CAN9+XWFkfJAspr0va_sexikjT9QvzbuqBo6hOL8_X=v-JaWSgw@mail.gmail.com>
Subject: Broken brightness control on kernel version 6.13-rc1
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

I have an ASUS Zenbook S 16 (UM5606WA) and I noticed that the display
brightness control stopped working after upgrading to kernel
v6.13-rc1.

After reverting the changes from the following commits, brightness
control started working again:
 - 7875afafba84817b791be6d2282b836695146060
 - 38077562e0594a294eaf4d8e6bbd8c1c26c2540f

Setup:
  - CPU: AMD Ryzen AI 9 HX 370 w/ Radeon 890M
  - GPU: Strix [Radeon 880M / 890M] [1002:150E]
  - Distro: Arch Linux
  - Kernel: v6.13-rc1
  - GNOME 47 on Wayland

First time posting here so please let me know if this is not the proper place...

Thanks,

Emanuel F. Oliveira
