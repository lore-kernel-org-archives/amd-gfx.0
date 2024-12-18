Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D4CE77187
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2024 14:24:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338F910E440;
	Wed, 18 Dec 2024 14:24:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UbraxAXr";
	dkim-atps=neutral
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34CB10E1C5
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 12:42:58 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7fd17f2312bso4492334a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2024 04:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734525778; x=1735130578; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cwl/uh8GVWIpn3YJFFjVjykB5+aXlEyEtb+Rs2CBw6g=;
 b=UbraxAXrzLRnoSE+eRUrrdAdllqK9NKkhvCMsERJ1REv6aT0dQazB/GOojXCGU4VE9
 pt0lcHFD+O/XMU45ka03OOu6eweZP613Mz8dCKEG3JaAyYMcORz+LqVVVMx0QDYq9h2/
 2sV6WahRvnP1latRsbPPrhcE0TK4j8944bP4ni5hncf7P4Hyi8CZVj3+DbjXNdk5y4Y5
 yCgLXCe0RH0VZ5uTsLahNGAeOXj0SjXeOu8a0sRP6CYPip79pP3eoR3cPkBbQTXb7oQb
 IgL/DgCCUvOCWSja8gqOR4hDWHmGLjZdNDMoFx3VkhHzcjSh4h7m18Dzjn7xMW1tGboE
 FYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734525778; x=1735130578;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwl/uh8GVWIpn3YJFFjVjykB5+aXlEyEtb+Rs2CBw6g=;
 b=BgWG7Y62lGHIs34txvsqHwMgS0HcNAiI8H90kLj8lpgThLriWAlVtk9rvI0q4kHaUA
 VxYt//Ixxv29QP/1rsyOzIVxcCSv32ZoxJBtA3vQeqOUKoPzLLyyCw5vqBrfAytf/msE
 iHeI36FZX5kkHvMhnjKT1mk7NuSRfG7rgHUeh5g8doRGAo346yDq503DJyq4vPRPkgbl
 Shg4l5U+n+Dzdb2Z3h155/dMmC5I1p+eWKlQKzfuqBU78w2vQxeII0cFpOhbl00YfrKn
 i2n9YKxf924SEtbXSBCGns9Anc07OrRbNaDIMElO7CjzXZCZ1qWRcJP+vbAGnzdONObt
 o73A==
X-Gm-Message-State: AOJu0YyvPqvzOq1ymeuZSEm1lhbnINZWqt7Zq81EcrCAWQ03ag5nvnIN
 ylr4v4cft/McW5Acwi6Ma9RXtephesSnSmVbokZDG93ggSCLhvB6qzoW+2fd/FkDEwQNrJ+gAU+
 JYkCS5P5w8brFf8Nj/CunepwRYQ5uehFX
X-Gm-Gg: ASbGncsGqODcfxavyMWHyhN7FlGyMe1h2U4MU33d+nqbdOXCuBAs4jhgUCbGVvbLQKU
 Qp93Kvpa0j9zB2y6IQ4WxAiyHm7DH2FM8axcTUveFKC4Ec/NLZSrkayW7wFZ0ZiXkqnLfGSw=
X-Google-Smtp-Source: AGHT+IGN8SNqRITIn7LNK39hCG/2QiTvMwjgzBnaC+P7nOAGgTLIutsola6O/nFIfpp14eIV45WAWqVhu7FCtilxNaM=
X-Received: by 2002:a17:90a:ec8d:b0:2ee:bc7b:9237 with SMTP id
 98e67ed59e1d1-2f2e9388a5cmr3666831a91.27.1734525778186; Wed, 18 Dec 2024
 04:42:58 -0800 (PST)
MIME-Version: 1.0
From: __- -__ <isapgswell@gmail.com>
Date: Wed, 18 Dec 2024 09:45:07 -0300
Message-ID: <CAN9WMdN5x-DbN3+e9FgKh4ROZbuxpdUvxwQj1oF_K9mKueffeA@mail.gmail.com>
Subject: PrimaryGPU
To: amd-gfx@lists.freedesktop.org, ray.huang@amd.com
Cc: Amrit Singh <amrits@nvidia.com>
Content-Type: multipart/alternative; boundary="000000000000dcda2106298ac0bc"
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:24:17 +0000
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

--000000000000dcda2106298ac0bc
Content-Type: text/plain; charset="UTF-8"

Hi,

Dealing here with xorg setups, i have set onto my outputclass section this;

Option "PrimaryGPU" "autoload"

Former means after matchdriver case yes, do output/input from respective
module by video-xorg-xserver grab its modeset first ...

Thx

Luiz

--000000000000dcda2106298ac0bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Dealing here with xorg setups, i ha=
ve set onto my outputclass section this;</div><div><br></div><div>Option &q=
uot;PrimaryGPU&quot; &quot;autoload&quot;</div><div><br></div><div>Former m=
eans after matchdriver case yes, do output/input from respective module by =
video-xorg-xserver grab its modeset first ...</div><div><br></div><div>Thx<=
/div><div><br></div><div>Luiz</div><div><br></div><div><br></div><div><br><=
/div></div>

--000000000000dcda2106298ac0bc--
