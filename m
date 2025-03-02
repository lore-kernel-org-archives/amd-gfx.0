Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F6FC282D4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 13:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FB0310E42B;
	Mon,  3 Mar 2025 13:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nS8d9x7z";
	dkim-atps=neutral
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com
 [209.85.221.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 144B410E059
 for <amd-gfx@lists.freedesktop.org>; Sun,  2 Mar 2025 13:56:33 +0000 (UTC)
Received: by mail-vk1-f177.google.com with SMTP id
 71dfb90a1353d-52099627b5aso3580616e0c.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 02 Mar 2025 05:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740923791; x=1741528591; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M5HAcacWBCbkb5NLTaTAiIHTc+6TkHVdrNYBDFwvSyg=;
 b=nS8d9x7zPoEHZdT2qJruwzUq2Et/949RA/fVXL1jr/D3zCqbPqibsq0rLaNpx/EsBI
 aimw4hRGjp6UQAsSLn729myYXWchqi9IteAkfR+AcKIZ1K8+osWGAw6zpgL+CA3xxLqF
 W1KcxN8xOKI8EZeM9Gnhu/MlbScQlpzQ80va1p3Ta1KIs9jh00MLh8YWavv+rut345rP
 fkx6Mz3cO3ENJI0jhznN5RkyqlkUFKOcMHjF4nuBO6x9JXtrMdDLxUPsqYEexJqAIf1h
 ZyqUBxuL6hpGTNoShA2Z17xBQ7yWP53J/6NaRFaHmN7a1o7AOFE/U2l8/SLjjF+D1LFO
 vHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740923791; x=1741528591;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M5HAcacWBCbkb5NLTaTAiIHTc+6TkHVdrNYBDFwvSyg=;
 b=iV9/z41No76vg2GN0GSR+VsfyJTrW5ndsf+qhvhZ513nTFkTQ+ajyIlgcFbVjz8S7c
 vy66qtsvNx9owRG9ugC67DuF+A/jEGJ6mqFvBqsguJLeYEwFxpcjtzC+inJkyrBTdD+V
 yGLLS8bIicWHYLD2enf/ddKHwSwhjkmiZh+eelDRRpewJ2H/WUgBd54u2m+aMDkeF0gH
 7ScmAyLneNB8Z/UC5YyZ4LiruhnUSTxvjVm5bC5EpPkXppGlHY80Im1HDTEgIkxjxaRH
 ZifAAJg0ETOi6RCnIeGr6wvg1zeDrYZXIgStCUQ1k7ukKaNDU9QCZCiWbvY8sOAB2CV+
 8cSw==
X-Gm-Message-State: AOJu0YyQBLDRsxMYNnBweB9Vu35GaKsi0XMyitiTFoH4HfBf/GfPlRoD
 wljYmU6ZrpYMaYbxLqg8IgGU6KyimbLAF1Z8kl6Epy6ydFD0EIOzaPAn1CNhPf0b18vitko/NPD
 YNg52zChex3/O0/YBUmS2bxmACc9jTIpC
X-Gm-Gg: ASbGnctqJtaeHhWgK3cJHghQ5JP+lvuTRl4aCrbEqP9QITfZzDS8lBZi1SRJNPBjXup
 FlOu0rf6BumM7/Rd+FkIeQxWnR1UxKqaVi+vmpntDoFYGd5nfRrGzglimn0PZcwD34YnbWb4gQD
 cpwPQ1Mow8RVbkKSSGwFjeb22+
X-Google-Smtp-Source: AGHT+IG8GxTKk0/NQPJeGZVvnBE3kFfhGA6HeGLdld4QLXu2c97x+7efXvVn3dCgdAe/JNx4rXS8X6XaYC9m/hLEqrM=
X-Received: by 2002:a05:6122:3655:b0:523:620a:ffd3 with SMTP id
 71dfb90a1353d-523620b02e5mr3810647e0c.1.1740923791375; Sun, 02 Mar 2025
 05:56:31 -0800 (PST)
MIME-Version: 1.0
From: Adam Lemieszka <lemieszkaadam@gmail.com>
Date: Sun, 2 Mar 2025 14:56:20 +0100
X-Gm-Features: AQ5f1JoKrhrqYK3z43__wl8ZkD8CxL6_iJ6hSvM5_sOe1wkHSVoFccZLEKnKS3U
Message-ID: <CAC3=24fDvvWMGBaJpxJeC7isR9rhkQ89Wy5=ZwmmUiC62tWbEQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] Add Picasso support
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000002a83d7062f5c68aa"
X-Mailman-Approved-At: Mon, 03 Mar 2025 13:58:00 +0000
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

--0000000000002a83d7062f5c68aa
Content-Type: text/plain; charset="UTF-8"



--0000000000002a83d7062f5c68aa
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><br></div><div dir="auto"><br></div>

--0000000000002a83d7062f5c68aa--
