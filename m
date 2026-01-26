Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B8AC88E4F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 08:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646FE10E4E5;
	Tue, 27 Jan 2026 08:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OdhGN+3o";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64F9F10E491
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:38:19 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47ee3da7447so38952845e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 12:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769459898; x=1770064698; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O6z4xoEpihhro/o4qh/O8qRrlctdYIYONRKVUWA7Hps=;
 b=OdhGN+3oPRIW9Xt/YjDbbXtPIpiwCsjwe5xm7A5NiFYIHqt9HAu/FpRn9K6en2geX2
 qZlXMdh0ByZT4+QTWjqQYgOqf0ATLZYHixxxoYt51dnDY0t3XaMcOgIon9+VZi3aRTO2
 OTVXBkr0tXJ4o6OLE9+Ql4yMcMTve9bB9y8kNg0Qxt4AggCvwgyoZYaD8U3VYOPjqcNv
 +AdZuK9mbbfdmxKOtmqnSzstnIR0cnRo7oGhtdNKtMoVEiYhvreJ46yjxNJypCaQwC3I
 QspPt5Knakw4O1haHZWN2A8hDSto8OyWIeflLWj4An1XlwzMXn+js1jqnQYI+rKchbGf
 NidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769459898; x=1770064698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O6z4xoEpihhro/o4qh/O8qRrlctdYIYONRKVUWA7Hps=;
 b=SRwQKl0XzqZQ8Jy+9Ue0zGm3pTNZzGpIYxbS54cUrDOzJ16d7+sLX/r21rH1NvNfEG
 7Haby27hOAeRtIZfKoL2bfP9xoXFJ2QMGKL0O20LnUvBoASqt0Nj1eeBzZwf3lSsQ8db
 XWabTJUXIy1Y6sZfQji11RkZHtoSchq3sVeNSEuId29TWenjaNoW6xs6e/ADwDOIGGjr
 tbjyLaIyE+NHi84+nw5na1m8kW9+lOfbqdPaMjsx8nnGN+lehLaiHjCyrpJBhbpIOPZb
 FENXieDuwDjwM+WONEdvo5AtIO+2qfl8YFGK3M7YJ5GafbcC0BIg8ln8wt4kf0UaeHC9
 kYwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkhsh6zWVc6/mrNuznR6LqdE9lnlVLN9oS7E5JrpYPAnnbTk2i2oqn/tpM0HeebuTqbxj4V+Yn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzfs02uqIYUtXTpe/Cy95Io4JxkW8gSeAw5CcM7k/fuW0XDjQlA
 9MA4uFV1VmFbTjmYEGqWvcbCIDrt0zBXUafjemnPJkh7DRmlKByke65S
X-Gm-Gg: AZuq6aKpUjHRBesyXrd0w7GXaXcqKNjyMgX5+CSjwV24gdqDic4xc1cR0xK4CYddXOe
 R7lQFNd00lQDzne3D76vxyqMjD0IEdjs1LpyiwH7orr3WUHGYrHjauP3npxOqz6hHATWkm8NNWp
 VejUDTc/tDk3LVKJDHgIzrR/W0aUY4TQ4n0676W7PLradWqyhgrsoVrnzt7kBO8c+eKizy+ouOX
 ygaf0tkMFTkcElT9yIPg0Tj78l+DW2cPYT6aPZWDX4TMRjZTr529SlFo+r9a8euaFbXOGbyvROJ
 d0fc/NScO8kFxKUu6S/7XuhX21zkKYvRjvjUJh7ByzcW2MVodHik19Kvjs87uCuHESL2J0ch2TN
 7UxjsImUGbe9SXIbVV/VXf/3k38jrnZEPltDyih1Ah4M1b2g13D07WdNJrLTEo1n6mBmBsD5VBx
 n1LjlkkxL6rTqCASQA/J7SH3KIy9D5Jub5ewO5Sw==
X-Received: by 2002:a05:6000:288c:b0:430:fbad:687a with SMTP id
 ffacd0b85a97d-435ca0e291fmr8983071f8f.13.1769459897573; 
 Mon, 26 Jan 2026 12:38:17 -0800 (PST)
Received: from ionutnechita-arz2022.local
 ([2a02:2f0e:c30b:500:c472:222f:bc60:d893])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1e716b6sm32591742f8f.27.2026.01.26.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:38:17 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: alexdeucher@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 ionut_n2001@yahoo.com, linux-kernel@vger.kernel.org,
 sunlightlinux@gmail.com, superm1@kernel.org
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix TLB flush failures after hibernation
 resume
Date: Mon, 26 Jan 2026 22:37:50 +0200
Message-ID: <20260126203749.16389-2-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
References: <CADnq5_MSvWLVqhgkdaYn6bjPC2L2=jf5v=h3n1cx=ZYgnXLQPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 27 Jan 2026 08:19:15 +0000
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

Hi Alex,

Thank you for the feedback and for taking the time to review this issue.

I'll add debug code to capture the full stack trace when the TLB flush
failures occur. I'll test this on my AMD Cezanne system over the next
few days when I have more time available, and will send you the complete
call chain information.

Regarding the hibernation limitations you mentioned - I understand the
challenges with secure boot compatibility and VRAM eviction. In my case,
I'm not using secure boot, and my system has sufficient RAM and swap
space to handle the VRAM backup, so those particular issues shouldn't
affect my setup.

I'll follow up with the stack traces and additional debugging information
in the next few days.

Thanks again,
Ionut
