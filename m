Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A7D9C28B28
	for <amd-gfx@archiver.kernel.org>; Sat,  8 Mar 2025 08:39:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7119710E209;
	Sat,  8 Mar 2025 08:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVn6/3zJ";
	dkim-atps=neutral
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com
 [209.85.222.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5CE310E31D
 for <amd-gfx@lists.freedesktop.org>; Sat,  8 Mar 2025 08:39:32 +0000 (UTC)
Received: by mail-ua1-f51.google.com with SMTP id
 a1e0cc1a2514c-86112ab1ad4so1043013241.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 08 Mar 2025 00:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741423172; x=1742027972; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nWABRiBMEGZhC1tnXRY5E4aM0eVcU26Q0nBNMmfHWiI=;
 b=QVn6/3zJstROOP8IwcUKJ/4nSUvkFc5aptq9dcCWHKng7VTProPxFr2M7V7s1poztv
 cqokYCI6Bl7HXBlGBCCZ8L802r6NSb1fPWR5lE0sHnbxGRvUS/AfkHvypdcAvo6/4K3L
 9v7K6UxKOKZGnZr1ViUHxG026AeUtQNjnaMT5Z9uAFF/r7uuNuPLLKKyhAo2fezEh4gZ
 5IohJ1TDgx0J5MZcr7qypsANkyhPgLiX1WxxLQ0E2Uih0r6JFECwR3o5IMyhuZVXu5vu
 HSwsFn1rztHWEQ0t07FoNabPizoxK+epPYVRMYP+Kn+ixtL/0q+iYvp5NM/DBPHDXjfa
 gZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741423172; x=1742027972;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nWABRiBMEGZhC1tnXRY5E4aM0eVcU26Q0nBNMmfHWiI=;
 b=JRVxxL4cif0BX/d4N1nJPJsuzHrI5KNHP24yuimWN+tmsN2wDXfjJNZCbs+/mh6hwF
 LV2KEheH56tgkltclmWK4knsyagH0K281TEHltdloG6yOJ4FKrwz3Swev1hNxhhsHO4M
 BDfWZrG6g2asYu/xBouqko2UYzDPyVRvPu6ehT03vhm3g0RdZNtubXEWxr9gULW5AYfr
 FMoMBaT53DrMCqPHzL3ygdX8VwzjvErSoflVPcqEuF49+wbsZapOHvdEBkLufR7ZAibj
 GFZdqfn5tZ1uxImiVtugX/pmt5B7piB1PH1m4jaKLrah5TH+falOAf0ohK0czZ8gpbhs
 0qMw==
X-Gm-Message-State: AOJu0YyunZJrbImbi4OBBLy/YVduEwi92CFbdMh2T94lKOxvBC+ALc8s
 iBiYVSnF12S4UlLf8U78S3KMS70utX/E5i2kxIuJN8C8Y5M0u5XnAasG9aqQ+t8Wtsw5BZJhbyP
 xhgeP9N1r3FqaWnzby2hBa9y5vxG3hg==
X-Gm-Gg: ASbGncsX9AZbN+PNV6igOuZzLkPrU838zSb2ZYC+7Gy5ihVMW1bbUP+sGDE7n9aXH9y
 +TvkLOjpcX0C88X0sc0tkZJ8OqfVbN8XmKVQQTAqbBygOw27DP7cAuOZIjhBT5iPcyhmk6pfMNw
 44utSZ3jzuc0EM4KLzIGQPtdmQdu//wHZhHpg=
X-Google-Smtp-Source: AGHT+IFyE6qkccuAchXSxoKHxzjOLV0YceqHl2H5pWuAmSmz651axeXhkoBXBdYeKqLrtW8hp/WOD1khN5qQGMmAOyg=
X-Received: by 2002:a05:6102:3747:b0:4bb:ce42:40e3 with SMTP id
 ada2fe7eead31-4c30a67e748mr4321850137.17.1741423171712; Sat, 08 Mar 2025
 00:39:31 -0800 (PST)
MIME-Version: 1.0
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Sat, 8 Mar 2025 03:39:20 -0500
X-Gm-Features: AQ5f1JqSIYAhYDrgdWpatTPHf4f1vtAqcjmWqC8yfWWqHOXxdE0Jmk_bGvdyDY0
Message-ID: <CAPEhTTEfGK031+RiifE2RYMphms4dNMiXEJ49KkL3azq10UvDw@mail.gmail.com>
Subject: SI DMA: clarification on naming convention
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>, 
 Alexander Deucher <alexdeucher@gmail.com>
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

While working on cleaning up sid.h, si_enums.h and some other SI
related files, I've been scratching my head about why SI DMA files and
variables were named "DMA" compared to CIK and over where "SDMA" is
used.

While I understand that a new system DMA was introduced with CIK,
isn't SI DMA also a "system DMA"? Could we use the same naming
convention and talk about sDMA, name defines values, shifts and masks?
Could si_dma.c/.h be renamed to si_sdma.c/.h? Was the naming
difference introduced to CIK so different that the naming covention
needed to be modified?

Thanks,
Alexandre Demers
