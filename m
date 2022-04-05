Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06992C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Apr 2022 08:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9D010F28F;
	Wed,  6 Apr 2022 08:13:11 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4EFA10E380
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Apr 2022 17:40:06 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id c42so8354840edf.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Apr 2022 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=HofrJDr98CScFReuycNlVD0pUKcZaoJhzWH+9eH1i/M=;
 b=qeo/NoexJRn3DtZ3ht579GQoivekcsE2eEMqw2bR4Z5tgWp3sfbUgwnzCPmpDi3Z0E
 XXJrIKXknOzZjkyluCDjqXDCpZWCgMSQJOv1jad2sLeoAbEzIKJrEbv1ZGesUDlRmKfw
 wrXasCYpW0qXN8iKKTas2UYCmiIch69ndbd8NEfdzZ0aBEASREgeXobShjiwJ+ChdODq
 0KGYbeTW3ATtdLiYHkvEvNDFw7oslMxX3B68yaDtYeMeBS5WCS3EGm06NZvWmRIZZntK
 5j7yAdj33TtYwpbJQHN8+DZVAiJfXjCsHRV3J+SZPFb7s2JqWCHYAQPdgWaDS3q9ky2W
 cjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=HofrJDr98CScFReuycNlVD0pUKcZaoJhzWH+9eH1i/M=;
 b=nt9hbfEAZdGX3fa0vMH1r7ykMhydnxYawKNBLgO0RWw+ZhlxEXxQcW1XtkXIP6L6dg
 Kw4guWU2o1XY9zT4YIJRNRA3SfZ3dpVGCZwytzww0wygZG/JCZD82+OAb5BY0yFN61qg
 0NqYMB0wsFiBIrlB5FSvdC5F8KBGTLi1lMp6/cj56oWR96G0gA2ruFOzUpfX005QWbp6
 LZq1/dOUwCafCMa0Yp+yVZZlUumoXnjMjsVSe2shNFVO1r2YwIIzVgLJrKaqlqOtzPuk
 tMQc/A3RE1vPyUnFHK2nO4qYpmGHphSaPKVDcyuu2f9vWyn2lWQOV8EC4XsoyiFghDiy
 fbfQ==
X-Gm-Message-State: AOAM532Brc5YnGHWqaxxmUEpcRHuGo9bUR2CdMXgvhbYT7QfRnd0DOd6
 R8t5rb3P0Y97/QUSsnGZUQRPFd4SjnXxR6wnq1Nw6v0Mnlc=
X-Google-Smtp-Source: ABdhPJytMofr4wGV4r4ssxfHb7dn+HzZzx9qCQh0WoUMMLq/F/y0qtO2Aa+0zg2a7FxVKJO6AWhSwQf/wEos6XdTD6k=
X-Received: by 2002:a50:f106:0:b0:41c:d793:3ae5 with SMTP id
 w6-20020a50f106000000b0041cd7933ae5mr4829156edl.390.1649180405163; Tue, 05
 Apr 2022 10:40:05 -0700 (PDT)
MIME-Version: 1.0
From: Maxime Schmitt <maxime.schmitt91@gmail.com>
Date: Tue, 5 Apr 2022 19:39:54 +0200
Message-ID: <CAPdf_3mLX49uBfyJwpMbcyumYQCqjqXB+S3gzWjdS9TCfbEVRw@mail.gmail.com>
Subject: [Question/Bug?] Why does the sysfs current_link_speed report a
 different value than pp_dpm_pcie
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000386c8505dbebbca2"
X-Mailman-Approved-At: Wed, 06 Apr 2022 08:13:08 +0000
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

--000000000000386c8505dbebbca2
Content-Type: text/plain; charset="UTF-8"

Hello,

On my system the sysfs file "current_link_speed" is reporting "16.0 GT/s
PCIe".
The GPU has support for PCIe gen 4 (AMD Radeon RX 6800 XT).
However neither the CPU (AMD Ryzen 7 1700X) nor the motherboard have
support for PCIe gen 4.

The file "pp_dpm_pcie" returns the following:
0: 2.5GT/s, x1 310Mhz
1: 8.0GT/s, x16 619Mhz *
Which is correct.

Is this the expected behavior?

I am asking because I recently added AMDGPU support to a monitoring tool I
maintain (nvtop) and I don't know where to get the information from.

Cheers,
Maxime

--000000000000386c8505dbebbca2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>On my system the sysf=
s file &quot;current_link_speed&quot; is reporting &quot;16.0 GT/s PCIe&quo=
t;.</div><div>The GPU has support for PCIe gen 4 (AMD Radeon RX 6800 XT).</=
div><div>However neither the CPU (AMD Ryzen 7 1700X) nor the motherboard ha=
ve support for PCIe gen 4.<br></div><div><br></div><div>The file &quot;pp_d=
pm_pcie&quot; returns the following:</div><div>0: 2.5GT/s, x1 310Mhz <br>1:=
 8.0GT/s, x16 619Mhz *</div><div>Which is correct.</div><div><br></div><div=
>Is this the expected behavior?</div><div><br></div><div>I am asking becaus=
e I recently added AMDGPU support to a monitoring tool I maintain (nvtop) a=
nd I don&#39;t know where to get the information from.<br></div><div><br></=
div><div>Cheers,</div><div>Maxime<br></div><div><br></div></div>

--000000000000386c8505dbebbca2--
