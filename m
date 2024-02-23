Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3718C48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Feb 2024 08:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F09C10EB3E;
	Fri, 23 Feb 2024 08:56:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="em86bRfj";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0804710EAF4
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Feb 2024 03:43:02 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-a26fa294e56so64769066b.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Feb 2024 19:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708659781; x=1709264581; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qoOcFPkVKT6UWH+zKsM+RmlENkGApFguws+kBmVRMLM=;
 b=em86bRfjEXnaKcgoxKYJxJwxnQKUd3woJtcecNA+eQjGwT8Yo/B6ErYUzbbo51IQ3t
 1VOHyYS2A7PztylFncgBt6hk1OKOGkIOD4tnqFrxBMmc/AxUyfX3GzKlMBGEpPwmcIbH
 ie980QGB3qMkkSD4Y+6+Y5yjMGdLcrsa1LYaGw4Sav4/88VLds5nEbMnYok0Xq8QrX6e
 wuh36KgYEuupe+MAaW5y0VPuEToF2E1gg5+YsaXJs3vNL3OS9q4kVq+5WcCtqx3X+L4h
 Axd986AWi4jyjeMu219V3S7qPsJ0qPCR9dtsMmJAZZv+2DLxsSMRYkcnuCv1C7NYNZCL
 q2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708659781; x=1709264581;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qoOcFPkVKT6UWH+zKsM+RmlENkGApFguws+kBmVRMLM=;
 b=pV9RD90da9tfkVZy2uJBVIz6D8LFq2cLAwDhJ5PbLSWu5q4dxvObaDGpEHLJWFMILl
 fLlKV2eTwEhm3eKuHE4ym+jiMWfYNO+d2cdWXTii4S0FAizZvmq8+OUYb9A1q0ecHX15
 nwvjak1ef+9DI4W6dCmxhwY8arafioFRW4JFZ+BIthDSmePOojz+cvftWJSCfZLCnM4Z
 Yl9ItRJ1ifxHZVYC3k/+s3LQkeku4dTjAh7zxNLsEnWQeXoBeTlH5kOchih+H8n1wVjc
 ADn7WvUX1Uj3LDmM93atZ450dpWfqiCykjcbU17LRkIScMtI1lBJYxi4YX6E4OIFmuX7
 bzHg==
X-Gm-Message-State: AOJu0Yxh0IEDF0Rd0xSkbM8zbNCMHdsHxBF4eS9uCq/8/J0OZI0ldVt2
 GpHFws2QafswOKgOgZ8+k739qLbdGchddfihetA2Fc8HQSlNkvUcC+W11heyuvTSDh+QpvJ2naj
 cvIOuojiOdVfDQPtTW+2WaH2zxjvZe1N71XE=
X-Google-Smtp-Source: AGHT+IFkakkAFlVkM2Jw8IubBiEjm0Ryl0aUIy8Rjjwqrf5hgpZU4Kv4pCXOLl/4BB37/OTkvMjjgUcDKkiKnnJg0/w=
X-Received: by 2002:a17:906:6b8c:b0:a3e:dcd2:2746 with SMTP id
 l12-20020a1709066b8c00b00a3edcd22746mr478232ejr.3.1708659780788; Thu, 22 Feb
 2024 19:43:00 -0800 (PST)
MIME-Version: 1.0
From: __- -__ <isapgswell@gmail.com>
Date: Fri, 23 Feb 2024 00:42:50 -0300
Message-ID: <CAN9WMdNLJmhUAsJv3yTLWnLZ-BnkpDJ6HrCX4f9KELyd1-egBw@mail.gmail.com>
Subject: [INFO] mutter is a mess, wayland_xwayland
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000046a47d0612045b6a"
X-Mailman-Approved-At: Fri, 23 Feb 2024 08:56:15 +0000
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

--00000000000046a47d0612045b6a
Content-Type: text/plain; charset="UTF-8"

Hi,

MUTTER_SYNC=0/1 complains, client/server and both?

example:
xorg_xfree_server((mutter_sync[0]) +
steam_linux_client(listening_local_server)) + game(x)
xorg_xfree_server((mutter_sync[1]) +
steam_linux_client(listening_local_server)) + game (x)

wayland_mutter_sync((0) steam_linux_client(listening_local_server))
wayland_mutter_sync((1) steam_linux_client(listening_local_server))

... sorry not continous ...

I think is simpler coz:

 cases,
MUTTER_SYNC=client_sync_focus
MUTTER_SYNC=server_sync_focus
MUTTER_SYNC=csc (clients, servers[wayland_xwayland] and clients) <- this is
most expecting ...

What you think?

--00000000000046a47d0612045b6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>MUTTER_SYNC=3D0/1 complains, client=
/server and both?</div><div><br></div><div>example:</div><div>xorg_xfree_se=
rver((mutter_sync[0])=C2=A0+ steam_linux_client(listening_local_server))=C2=
=A0+ game(x)</div><div>xorg_xfree_server((mutter_sync[1])=C2=A0+ steam_linu=
x_client(listening_local_server))=C2=A0+ game (x)</div><div><br></div><div>=
wayland_mutter_sync((0) steam_linux_client(listening_local_server))</div><d=
iv>wayland_mutter_sync((1) steam_linux_client(listening_local_server))<br><=
/div><div>=C2=A0</div><div>... sorry not continous ...</div><div><br></div>=
<div>I think is simpler coz:</div><div><br></div><div>=C2=A0cases,</div><di=
v>MUTTER_SYNC=3D<span style=3D"background-color:rgb(255,153,0)"><font color=
=3D"#ffffff">client_sync_focus</font></span></div><div>MUTTER_SYNC=3D<span =
style=3D"background-color:rgb(255,153,0)"><font color=3D"#ffffff">server_sy=
nc_focus</font></span></div><div>MUTTER_SYNC=3D<font color=3D"#ffff00" styl=
e=3D"background-color:rgb(255,153,0)">csc</font> (<font color=3D"#00ff00" s=
tyle=3D"background-color:rgb(255,255,0)">clients</font>, servers<font style=
=3D"background-color:rgb(0,0,0)" color=3D"#ffffff">[<font style=3D"">waylan=
d_xwayland</font>]</font> and <font color=3D"#00ff00" style=3D"background-c=
olor:rgb(255,255,0)">clients</font>) <font color=3D"#ff9900" style=3D"backg=
round-color:rgb(255,255,255)">&lt;- this is most expecting</font> ...<br></=
div><div><br></div><div>What you think?</div><div><br></div><div><br></div>=
</div>

--00000000000046a47d0612045b6a--
