Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43BB7C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 15 May 2022 15:46:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FCF112458;
	Sun, 15 May 2022 15:46:13 +0000 (UTC)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCDA7112458
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 May 2022 15:46:12 +0000 (UTC)
Received: by mail-il1-x12e.google.com with SMTP id 3so8985531ily.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 May 2022 08:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=zd+vn1Lc/sBBi2pRxLJTDfluX1tzZ08uKxrkeUHg+qA=;
 b=g1YADS4HmM2/Cm+zt9aW7a2BmqpRlmwoOp2xfqBNWqj45IldkEEfSSl3e9jgfYBVJf
 Rxw9osUsX8pGm4MV+JYmI6qcLM3sdHk9PgcKwSToFToYvEFbqllRtqqkCHFCw1hC2bd4
 9evCRzX/YTRw8LN/rhEebiin/nLErJgnYNsQtKblfnK1K4f3hfp1u9Rszk+iJoDcbA3W
 jHP+QHRW7FKaYEQEpgJMZMzyKlsnl25HCNytMwf3IJM8Qh11d1FtYwe/aEhCtIb938hV
 0bmg8XlME1hOMl/22j5r8C1PTqgQ1u3+HyDaWzx9BjKdJZ1o1m1VTCWHcMAIFsK9kBa2
 KPVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=zd+vn1Lc/sBBi2pRxLJTDfluX1tzZ08uKxrkeUHg+qA=;
 b=C9j0oXOOyTAwC1l7hA5JtbpuAXYioF22xfpgdgCaiWjI3RCbPolxCg59XtMubCT8G4
 JHgCGYhs6RMYsFmObVrtpgv5ybSM7I4aKOkmWQ68dMm/hEH1H7P+UqBkeHt5hQeQLCYN
 NY4OrUyD/j/AE1bfTOq62tJSE73UohPYPBnuaeOUIiit+gXSlO9gtyrqEk2tuEbPgcFZ
 xwtCPnrE2hG+SmO/w06vI9eJePTqVX+nJb2pw+WPXiyNxQw4QaSGKkrTjU/V4M6GK0+i
 TgbY7UtBLdk74tQ/By8YHdNnL5x7QRkbHNr8PHum9ePHCux9h0mOSZHWhLHN6z4ftjxD
 RYwg==
X-Gm-Message-State: AOAM532RGnszsgy0EF6iJt+gXtVQMzQnKDf70p9xr66R/87Lgfb5fLAf
 piWfq/TEQywM6FOUM1MiCZp/3zJNnk2giDfsAaunUDQXVAI=
X-Google-Smtp-Source: ABdhPJxlT/FdA5aRFFurXulN2dmsnkYd05O5HBWfmBB7zS9HiL0B1vyiiqhqqprbROnUxY16mXKrByudatS6pnW4LKE=
X-Received: by 2002:a05:6e02:1ca1:b0:2d1:1401:80b3 with SMTP id
 x1-20020a056e021ca100b002d1140180b3mr2307579ill.209.1652629571865; Sun, 15
 May 2022 08:46:11 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Sun, 15 May 2022 17:46:01 +0200
Message-ID: <CAD=4a=VSEST+6oiPRrMNNd1ByQm0e+pG=vCLb--bTXDZT0LnoQ@mail.gmail.com>
Subject: VCN_INFO_TABLE_MAX_NUM_INSTANCES vs AMDGPU_MAX_VCN_INSTANCES
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="00000000000093934405df0ece41"
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

--00000000000093934405df0ece41
Content-Type: text/plain; charset="UTF-8"

smatch found this problem on amd-staging-drm-next:

drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
amdgpu_discovery_get_vcn_info() error: buffer overflow
'adev->vcn.vcn_codec_disable_mask' 2 <= 3

This is caused by:
#define AMDGPU_MAX_VCN_INSTANCES 2
#define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4

Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and use
AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?

//E

--00000000000093934405df0ece41
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">smatch found this problem on amd-staging-drm-next:<br><=
/div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans=
-serif"><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,s=
ans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family:aria=
l,helvetica,sans-serif">drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:1443
 amdgpu_discovery_get_vcn_info() error: buffer overflow=20
&#39;adev-&gt;vcn.vcn_codec_disable_mask&#39; 2 &lt;=3D 3</div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></d=
iv></div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,=
sans-serif">This is caused by:<br></div><div class=3D"gmail_default" style=
=3D"font-family:arial,helvetica,sans-serif">#define AMDGPU_MAX_VCN_INSTANCE=
S	2</div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,=
sans-serif">#define VCN_INFO_TABLE_MAX_NUM_INSTANCES 4</div><div><br></div>=
<div><div style=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_d=
efault">Can we just drop VCN_INFO_TABLE_MAX_NUM_INSTANCES completely and us=
e AMDGPU_MAX_VCN_INSTANCES everywhere instead (and bump it to 4)?</div><div=
 style=3D"font-family:arial,helvetica,sans-serif" class=3D"gmail_default"><=
br></div><div style=3D"font-family:arial,helvetica,sans-serif" class=3D"gma=
il_default">//E<br></div><br></div></div>

--00000000000093934405df0ece41--
