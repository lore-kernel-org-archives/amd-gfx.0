Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76DCC982D9
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 07:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7306710F227;
	Fri, 18 Sep 2026 07:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RQnY5aV0";
	dkim-atps=neutral
Received: from mail-yx2-f30.google.com (mail-yx2-f30.google.com
 [74.125.224.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCDB10E38E
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 10:58:47 +0000 (UTC)
Received: by mail-yx2-f30.google.com with SMTP id
 00721157ae682-85d440939efso4843927b3.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Sep 2026 03:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789642726; cv=none;
 d=google.com; s=arc-20260327;
 b=EWn2mBIlfGBf8Z52m1mRocjbLUUTxcne9R0Cd1frd8aJ8G/OQS4m+yt+eeTGI0a2Oz
 /hwPWW39o3yk7ZaGW7f3/6hAE8lDKlnnuS2IczwutPklClts0MwMHasOdAJ6PYrLx6P7
 mESv1WWSiyjUypYytztjMhAaCHDzRTzwbhffQytvAeQP5Q4t5gkNJTGGdb3R7GX8HJaL
 ZxlJqYa9wScMqYJ/xno1aKiD8Znf5Fx4x7y9wacx8IpDan3BUW6/qWgp2XK504xEtHu3
 JkesjXxVGi4bhQdOJfDfJQkJpMBKrX7xXYhU6DeDKL9vKmddTSYB67WvRYKVSn0qHgls
 NCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7KhKyil2myWJvfEBan0AbjW4BYY6AMmIRWYedre9GPI=;
 fh=uy+os6md/3u/1zBzMydkvFetUe2RNJS4MenjhThNTlo=;
 b=nwjm4cWOuExHdozbHE1fG3QhCAcWufAhQlXLASkqemCHxvcLzCHzYLYtBwFiaPnsdJ
 jXSl4AsbUI5cvZ9nkDlbQbLZc45sbngKf2xWYx2I4egjVoMHEAkIbJ2w5npe24815ssu
 FT7du46j++4ewnX/+hCdM5Qa2et9GjlD8bqv9z9ifSN6sZAMekGKAzLk/ITpazTYAaxw
 +z1fjGj4OBuHGUK1TGHxhXNQQuYZ01+iAxit4TPBCn89vzIGpehx5tgq1HA3IfUa3yRd
 8XQl2EHMtDD4V9JSTnSDyYWMFG0TahMQEygFVZI9FfTZ+L49ZEAZfD95yWR8a98SM/fc
 htbw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789642726; x=1790247526; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7KhKyil2myWJvfEBan0AbjW4BYY6AMmIRWYedre9GPI=;
 b=RQnY5aV0sJyufw9lee7qF1dN8dbGNASUJPfU4Kj+Sr3k8PC5ezBYyjCg+X8iQF7Hoq
 Z2giknj5zwvwEhKVFwbnLTGv3q7iY43OyHdtzi17EWfjDhQ6dWuVX+ub+cROH5tRfTFt
 iGJkFscnYFb5Q7x+jpzTxBcaHmZtVHRYKsvAKw/MFPJPU9Zn4QbtqFinirlyy3FdAlxJ
 CUr4sVSfLVjH/JP0oPATJlyjNfkBrI8ldQQheFZnrNAGWU7Zn8ekRTp1nozF15PcNZ1k
 wziIsdQWN0n1K4RXTL6I5HX7scOiHYJI4f7vWrBmKqomnRh6t/rGA702eOYjm9RL84QJ
 FMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642726; x=1790247526;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7KhKyil2myWJvfEBan0AbjW4BYY6AMmIRWYedre9GPI=;
 b=e79hgmgcYcsqrG4U+54AP3I3braDq0Zp9JDpehFhSuQzr74NLxbaYwI7vkXvwhMkMl
 eoGtA8OEhnXT1qNbqo8RSbwpKgZNXbA3Jn/akWToe4Q0/YndcbJjJvcSpZ7blHh6wfo7
 fcRAikQOks6rye28DBQfdMHIlanDXR6OBW26pk+9O8+ApRNtNKFnkDwZOGxVzZDR6wGx
 3Onvj/x/m1tovp6yODulsySUY0/H/GYdk/nW8ZknAilZvN5pjhnywS9rWAyQ/6AgaF75
 nEp4fr59U6Usv9F5WPi1t/1tsCj+nkmECU15j+ztO8bwDcyV9oLwP59tsB179bhRXK6i
 8f2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUu2Jm5ktMKNI83sJ9aO/c4qHNd6Gj1kFz8E1IpLeo5UxeiuCrK4jhcm3LTcRTqwpGhJcu0XVE@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlIajWQ4nCxg/4v/ss5eoUcc9mtFcd+3RFVZjgwBxZzBXq67NX
 VlnOl3o3PvjzcC6BQYgbvnHjDGnYgE7rh0nqO0KGITj6q2NKBG7zaX5izhA/jV4FCQGkVlKDeZj
 FDG01ci8lFr4uWNPn1+2Xo8ZdtAegQ6Q=
X-Gm-Gg: AYBFou0+wYXNKtA8cOq+BOqlXHNB+ZBDhVae6+h4+eCs9BqAi1CsM9voqFwPA3n0E2G
 GDUm77qO1yw0cHDv1sQ+Fp7QL/g404j9nhL61GoIGjm6Y+i3TeBjsM3/iBYnTBJSdrH4WKCRmbz
 OmTv0Qd+5ODKjlIbS+LKmdwCOaeid+vGP6o2TXz9a1ibmlG01KiPMs+t5XMnAZQEDlkDVmBQCWw
 zRczKBvv6EzXr94CaJYWf7m7en1pXQ5v7jmkvb6bxAXKQxo8g0lX75XqBEJ4oI0Qi9QTfahrj89
 0ByZ+idtLqca2vA40eK/Y4RM5PXXQHyqWbKP2g/b143A85qhEDXEX8masaQV0OitwHPgeCXwoc5
 9iAbOUfAtQSIaRfoEOapPWBo=
X-Received: by 2002:a05:690c:e3c4:b0:87f:bf8d:3377 with SMTP id
 00721157ae682-892267da8aemr18956947b3.63.1789642725966; Thu, 17 Sep 2026
 03:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <CADGM-+Xgh23YEf4Un1oz+hKKv-_E_Va9-8Q23UyxfRA4ridfxA@mail.gmail.com>
In-Reply-To: <CADGM-+Xgh23YEf4Un1oz+hKKv-_E_Va9-8Q23UyxfRA4ridfxA@mail.gmail.com>
From: Gabriel Elias de Aquino <gabriel.aquino86@gmail.com>
Date: Thu, 17 Sep 2026 07:58:35 -0300
X-Gm-Features: AcwNN1UDaR6r68wR5QQ40JX_E9iwtfwdL9_6diMioe4zafX-Qnhbo3bUvSTlm6E
Message-ID: <CACndxTnRfusNN3B5Ozve021Z=q3qh_MrTEfs1aK7+E4JmOhRdA@mail.gmail.com>
Subject: Re: [RDNA4] RX 9060 XT - Pageflip timed out causes complete desktop
 lockup under KDE Wayland
To: Jacques Serfontein <jacques.serfontein@gmail.com>
Cc: alexdeucher@gmail.com, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000f4cb02065babaad5"
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:44:40 +0000
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

--000000000000f4cb02065babaad5
Content-Type: text/plain; charset="UTF-8"

Setting pcie_aspm=off in my kernel cmdline solved the issue permanently.
It's been months without a single ocurrence.

Gabriel Elias de Aquino
gabriel.aquin86@gmail.com

Em qui., 17 de set. de 2026, 01:44, Jacques Serfontein <
jacques.serfontein@gmail.com> escreveu:

> Setting power_dpm_force_performance_level=high has given 11 days
> without incident, versus multiple hangs per week at auto; no other
> changes.
>

--000000000000f4cb02065babaad5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Setting pcie_aspm=3Doff in my kernel cmdline solved =
the issue permanently. It&#39;s been months without a single ocurrence.</di=
v><div dir=3D"auto"><br></div><div data-smartmail=3D"gmail_signature">Gabri=
el Elias de Aquino<br><a href=3D"mailto:gabriel.aquin86@gmail.com" target=
=3D"_blank">gabriel.aquin86@gmail.com</a></div></div><br><div class=3D"gmai=
l_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">Em qui=
., 17 de set. de 2026, 01:44, Jacques Serfontein &lt;<a href=3D"mailto:jacq=
ues.serfontein@gmail.com">jacques.serfontein@gmail.com</a>&gt; escreveu:<br=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex">Setting power_dpm_force_performance_l=
evel=3Dhigh has given 11 days<br>
without incident, versus multiple hangs per week at auto; no other<br>
changes.<br>
</blockquote></div>

--000000000000f4cb02065babaad5--
