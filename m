Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115BCC433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 22:48:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D7964E2E
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 22:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D7964E2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44F256E3F7;
	Sun, 28 Feb 2021 22:48:48 +0000 (UTC)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DCF36E3F7
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 22:48:47 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id s7so1540812plg.5
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 14:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=QAXrw3Y3ch5fEXBi5nCjJuAK86V8MJ736xNeoVU8KEc=;
 b=lnmsHIcosG9rjXiwsg1qs/TnxXpLhwyLEYockB8G1sCjSCnqkq8hkCP38z3hPo/M+s
 Eu4W/jjubR0imiMg0vzAGXlzhkYwo71ODc0XNw7G/rAKD6bkUk8cwLn26B3KxHRO+ZPA
 MpCEWvj2WYZm6Kfoys7KHbkYK7NUyZ3mNI8MnA+5qQuBIhpS6Qhd9gZlpGmPAAyozSRw
 qtUc+y5SABlPBVwZKvBL9o8juCoXfBo46JIdOQfCS7h36hVrlRPxHhCRpWCHWMYD9+GJ
 77rDd1YzIsi8MUR+lhbhUQJkxxIHZssSh1l4u0/o6dUA18dMUzQU963ijWhGy30+QymW
 WyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=QAXrw3Y3ch5fEXBi5nCjJuAK86V8MJ736xNeoVU8KEc=;
 b=oSmWbzS6+sf0Stc5N3A4WnUgnzJyw6KGsArXK/KrT+QNONcS7Z0UKmtBjNK8ByS/HC
 ajWEWcJ8tq/Xm8rCh9ultNxyRxPu6QxeaQrrX9bYmERpm54Igh84yEJ0eFcLgpID/4Ok
 KRuoMwSgAFaYCeJmieiVA8KKwdzdpjwasugI9gl6efAseEpImfVdNcbdtD3gN/8FLYYZ
 zrDchSWCqBgvedJRbK5xari2uaL8nn8vxWlFKQ3SiS3QN4pykPsw6NBR6jzJcGLro/mm
 JcKJ8alD0TahH7bTEPG8QKBuUrCa479iBEPZn3w7SETFsslV/C7BVWYKoQQpAcruoVn3
 uD1Q==
X-Gm-Message-State: AOAM530SuJvNSWDO/IMicF+V1yfcbsabfczOa6PuZgB9q80X662m/+u5
 axK+EruxrygGZRvnrwNTCBMX6o7SXF3xXo6pukt8CSYUd9biuQ==
X-Google-Smtp-Source: ABdhPJwIiqwkwk9OsMzy4uU2LhQPBlSikt2Nrf+j1jXAn8lMIMtZgtBYOr+HHvxzwgUr3EZ0D0L+aubSenYtMxZdbPI=
X-Received: by 2002:a17:90a:ff05:: with SMTP id
 ce5mr3106649pjb.156.1614552526881; 
 Sun, 28 Feb 2021 14:48:46 -0800 (PST)
MIME-Version: 1.0
From: Adolfo Rodrigues <adolfotregosa@gmail.com>
Date: Sun, 28 Feb 2021 22:48:35 +0000
Message-ID: <CA+gx7UpBhKc0uwLhtN6ZVjWbMJuJYSJ9mQwk_fHtEikh6t3oRQ@mail.gmail.com>
Subject: 6900XT HDMI 2.1 -> Missing 4K120Hz
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
Content-Type: multipart/mixed; boundary="===============1006079671=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1006079671==
Content-Type: multipart/alternative; boundary="000000000000d6098705bc6d4d9a"

--000000000000d6098705bc6d4d9a
Content-Type: text/plain; charset="UTF-8"

Hi.
I cannot find a way to enable 4K @ 120Hz over hdmi 2.1. It seams limited to
HDMI 2.0b.. is it ?

Under Windows 10 it works fine but not under linux. Why ?

--000000000000d6098705bc6d4d9a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi.<div>I cannot find a way to enable=C2=A04K @ 120Hz over=
 hdmi 2.1. It seams limited to HDMI 2.0b.. is it ?</div><div><br></div><div=
>Under Windows 10 it works fine but not under linux. Why ?</div><div><br></=
div><div><br></div></div>

--000000000000d6098705bc6d4d9a--

--===============1006079671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1006079671==--
