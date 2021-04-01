Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424FBC433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 14:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8594611CE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 14:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8594611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3B26E14D;
	Thu,  1 Apr 2021 14:08:08 +0000 (UTC)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 708616E14D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 14:08:07 +0000 (UTC)
Received: by mail-qk1-x743.google.com with SMTP id q3so2219352qkq.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Apr 2021 07:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=3qVVc3QjuuQZ5h5EwPYr+yfHDfihvOOI1IEXdAdZ2mI=;
 b=EzoXuX7TIXc7BSY1H8u1JDEQPg2Y2rikJrX04lUlB20PdeuBxOuVI43l9tfOhCVh5b
 MSmApZ6tLU/M8MtPBf4/E94f6XpdMEglwii4VG7wUBAO7CJ6MuGLBhA/yGvhywTgv6dR
 BVU2NqHR9aLwBHpAL0YReiO7T41RinDYOR0fpq527uNZl8m/S8+swnPo9Yc2vZwW5ObR
 jZF972yrIKeBByJVB+uR+rpi6cRgQORo9zmYy67UN5afhLwX7/0aoyhhEcTtTRDgOgHc
 0CYFWdv8p7JsFAEO1J5mq/wriC5UEYD4uC6oUQiRB2p2z1XtpN4CwHTNQu129SN6inWP
 vhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=3qVVc3QjuuQZ5h5EwPYr+yfHDfihvOOI1IEXdAdZ2mI=;
 b=KY7IuX25As9cEREg5BY4pLyFeiNLwxqiEYejumepQFShuPdFBLXwhuTsQVFXqPRBgy
 2zsuKEM7MUDR9SEqjBbD4eF4LzUJTqPORVPIZ8T3MTFEDe4Y/iTm6RIQ2wxNup7lA3de
 QGGNBzK+yvOUviz3XZL9lVSV79HZRVEvJPiuWGG15dRYEYQTCfrjKTGnYJ+YnElYSuWk
 fNqqxm152qIL/fGlYm5/eyEGA4hFHMdQeAZwysOK3MI74QL7rVHbWOczLYEDc5vKYgGw
 i5MNU7MqZubCo7bs9H3ptlxy/GjeQpCPApg7gU5SMwlUISle5Rlv+Y6aWGSf0vAYpgQy
 YwpA==
X-Gm-Message-State: AOAM533m8xuzvWaOauHKS2KM89jSQfabIMA1dTN4gkVbf6vI9hU0gkDw
 ICa8ZZJ8VPdxqiwKHNLKdv7yEEnpdX4B6lwxBOm5dQPOmhg=
X-Google-Smtp-Source: ABdhPJyO21smIhkYUTLksVByM48WcVNvNf9106td/5gK6acvFjTnqyY3kTkYVD8iAObF8tLNHY4EMuhMJBNFp6Lj9bk=
X-Received: by 2002:a37:a913:: with SMTP id s19mr8717336qke.158.1617286086276; 
 Thu, 01 Apr 2021 07:08:06 -0700 (PDT)
MIME-Version: 1.0
From: Smith John <ls.cat.kth@gmail.com>
Date: Thu, 1 Apr 2021 22:07:54 +0800
Message-ID: <CAGztBWXhxjoOAQ2AbiR0KGEV3g0dSxYaWwUGnOg8w70vCW1VuQ@mail.gmail.com>
Subject: [amdgpu] Compute kernels still run when the host process exit?
To: amd-gfx@lists.freedesktop.org
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
Content-Type: multipart/mixed; boundary="===============0161928693=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0161928693==
Content-Type: multipart/alternative; boundary="000000000000ac3c1105bee9c22a"

--000000000000ac3c1105bee9c22a
Content-Type: text/plain; charset="UTF-8"

Hi, when I killed an OpenCL host process, the kernels it launched were not
terminated, and still run.

My OpenCL runtime is AMDGPU-PRO 20.20. OS Ubuntu 18.04.5 with  Linux Kernel
5.4.53

I was wondering if it was a bug or the driver did not implement this
"watchdog" mechanism.

--000000000000ac3c1105bee9c22a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, when I killed an OpenCL host process, the kernels it l=
aunched were not terminated, and still run.=C2=A0<div><br></div><div>My Ope=
nCL runtime is AMDGPU-PRO 20.20. OS Ubuntu 18.04.5 with=C2=A0

Linux Kernel 5.4.53</div><div><br></div><div>I was wondering if it was a bu=
g or the driver did not implement this &quot;watchdog&quot; mechanism.=C2=
=A0=C2=A0<br></div></div>

--000000000000ac3c1105bee9c22a--

--===============0161928693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0161928693==--
