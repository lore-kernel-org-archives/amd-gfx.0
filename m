Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B11CDE022
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A66B10F4AA;
	Fri, 26 Jun 2026 07:54:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RVx48wg2";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9168F10E1D2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 11:00:29 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-46e335379cbso148983f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 04:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782385228; cv=none;
 d=google.com; s=arc-20260327;
 b=WTHMxoZxFQlPjnFSzYtBWgVYVkImuR97Cakk0yU1gQ+OUp1W2wZxp1/WMm6YLsIdli
 h7mGARUjXZTIt0WzDFgbgFYR/UwGXlY7658W9pN6zKzBwk06CtMJqQOzHxC/aVXUAfpN
 fYyYC1L5Pz8s+w2xhFV4evB/YkIY+rjdlkdETR17V8LIqE/xdnspR5RVetPx4V4lNGrf
 OlBKtpcAM/KWxQ4BPhhCM4QcRfpyQI00vKJjhW4HVIwGJzvKVNzG0pmCo//x/MBrMcB2
 XcRQEmSIZopkX08cPCl5xr0p6/8J3/YP7k416nHKUsvqPTApLndX+2OME715it5vHbQf
 AFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 fh=Y8VWvczhtA2+qfWV4n3yFIjz11C0Tu5ciM95NunAusE=;
 b=bznkXlTe1MsW3fhu3xgPuK4XDW0/JFsI+oS2UzVKV0sXhLO7is6VmDZAz8Rxp2yyuL
 wHV59APvk7hpTipIvsfAaqxeKKKSf9HTmKYjF2B8+6yIu/NJvs57nvkzZf0VNUS9sNm9
 9zezLzdeCnztiY7IxQE8g4DydT7iYplnnufIfV4pEumQqlcfL8Q9uA5zCSqRtU8Kx7bh
 Vgs/SSp43q4aBrLycAst7M6I77caa3PNSUohxO3Ao6yjBhBc6eZ6tJTd1c/x7MaBcTIF
 nK0Yn6I7dKPyZiBi4wopnjUGyPBBHs/laFxp/fisXx51Op9w3bj48/SZCyskHGhdujrw
 9OpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782385228; x=1782990028; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 b=RVx48wg2CRlAt2vHkWcWHnrDX63x98TLxSUHTJakoDYvq2qSxe+ePYe/GwUc7a1Ez8
 nS+oYxaeotuJWEeVvNN5hAbsVm8YJlz6iKjSw3CBn42wZX2KvsYyHEU44vqP95817Wa3
 dgAZODUj/gaxSt1St4UJ05iPDYosNUTNEtN5RIYpG01Nfu4s4HFwHd4iytB5BzkaVOzh
 45wdiWe3ODdu7z+i+3XIRZ6bBwYZ1QydXS3EhEZSTOWHR+l65ZYXQvLSR0I5pUHiEyki
 VHdzzVI4P9nigE8/O2p5XBOWwvJKofN4Susalr9h/6HbN+4CnNdBr8+8d/wofab0+zWa
 tYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782385228; x=1782990028;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYJ9K/irCjAHZhFgkU4tEC3o9IbVrQ1kbJDsUWJW4tg=;
 b=Q5iRMIW6rcLSF3kK9YmedCJ69367+rXXJhYPTnBg0FUN2yTrQRzV92fEACg5ZBpexr
 j4QVpzxAxF8jEaDXkRB30CjKIStuKbdMPgFgIqYzLWQHg1PKKAzUEObnoHP7TDUuNqll
 6eWG2KRQ3WQwE/Jhv33W2BI3OoOaTsv98QAEktEn5PCfamK6+45fdi0zyOFHTnG8vb/3
 CU9AGIaQLcN5CqQZbV+fsxqlUxSvtsKPre1OR85CajsbhPEsCuUdP+gNkp41/0zhOFmG
 EfeNc1kTCIXVBF3W4Cft4y/J7j7EHQEy+CnqoqPH7moJzEnmWMdRYcZwfv/TDG7o3KwF
 i1Ww==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLHG+AaTjnW64KiEzNFWto2Wzg0V+MVMbG530WqxkA6utbdgGji1IqhEP1fKzJ8W51gA4TeGfZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwWrUuLv288Uj5MKXSM88x33Ig8COAQpH4Duw/YESI+2Blq/skl
 S/7dpiXQVynPGcg+xCHCj3GXH4q3pUoONtWfFj9QqFhGOS8sDQZ/J2clUPNFVUwWqLfRiJbfAHr
 5/b8ihUIz2iEnDGhGXihIE/ARFGT13s0=
X-Gm-Gg: AfdE7clLFi5QjGxzeAgZ5ZjVwASQIII7EmunYWU8e5ODr3Ntzv2lowxU7jab3N1+HO6
 7nwdM5mU3681hYJhE7Z38jCvuce3XgWGARfI8eUNT4BfwQHkMfZqgLKdfqQQzXCtoaZyHeahd9H
 hJwuJKeIizOg8RlkiKXZhAdq33KaH6V89Bk5t1qlPRGSDB8Gt+Xm+3PjRV5zThWvcvPuPh8yjs7
 22Y0BtNXB6+3wrwgqhi4fZoOl9vhaEJ8uPm40JszaBbugiQaFMxM1oWupaHihmOE4AeDQFg
X-Received: by 2002:a05:6000:98b:b0:46e:1bcd:6a0f with SMTP id
 ffacd0b85a97d-46e1bcd6be1mr1709213f8f.10.1782385227477; Thu, 25 Jun 2026
 04:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260521133537.3438468-1-maoyixie.tju@gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Thu, 25 Jun 2026 19:00:14 +0800
X-Gm-Features: AVVi8CdjQVfdmvFjsaSWCi4UnNz1OBoLuP5LUHLjBHGhcG0i8c0m07TuDEVi3ZA
Message-ID: <CAHPEe=GiP6GKaFWrd1M2Oc2Dod5PECD0nCwX1OfdP88nQM+z2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove dead empty checks in ring_mux
 ib_mark_offset and end_ib
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:54:04 +0000
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

Ping. Christian acked the approach in the inquiry thread, could this be applied?

https://lore.kernel.org/amd-gfx/ecab2606-e54b-4d21-93f0-0feaade64e6c@amd.com/

Best,
Maoyi
