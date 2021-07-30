Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08E6C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 08:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACCC60F6B
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 08:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6ACCC60F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2506F3FD;
	Fri, 30 Jul 2021 08:48:22 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 631436F402
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 08:48:21 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id ca5so14127603pjb.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=reNoPVdKkWnSEiJYODIYoDMGD4Ss+oFtvdM6zfaMyeI=;
 b=nzOfAZZFOdZVG/y697GkzGb6LU6Z+kPZYRCe+KnmcYGdOUCEygrHyGJcuwMRgE5fIP
 Ct4acTU/puBE2zdTuVDRlxDN9xNkN/3QDRhPmwu2oMQ/ic//ofsAjXdQEr4uB/fFtol+
 t/ZjgPKZQZheEutkEX6iG1sc2doGKq1FY+w1r77JRqTCnQAYO2ywPe6LcX4676EghVmV
 McNew83X5jvbI//IBy3hI9jzRJfL4cfnPe8GWHZNWFmSoHSu1XGMOK5IBAx5Xgrk842x
 SC5zbiHgkDDu8yXha6rhitzC8emSl8LkhxtC/8xwEP9/ha6pJeT7WZO7ONMJcCO01lzb
 He7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=reNoPVdKkWnSEiJYODIYoDMGD4Ss+oFtvdM6zfaMyeI=;
 b=bkyew0kJzBXnHPcIJ/XPxnFxuPbhPO3eh/y3QUBGyLjzT2ivzhBhBBSby3ShtH7n8G
 YWcGSrqi8pe0TwjDss9u/I4vurP5eRwgAUQWYG4WBkPlDgtdGClxYm+FUscoisu3iCYA
 0k9AGZ5dZy5TlCNRgT0fS2jeUcBp3jI/SubPlQWvnLnxaYss9zRIj+Kd/iLZjn9X2pah
 ZisLWyy06VibhR2oqwI2Z73ynefmLQp7E1i/riIi1UsV3Xxzd6qU0ECQHPLzvlatEroS
 OY4XU9bAiv+i0PNQWWOMfx3N09bSDXWpHmp5G3pcrZ60Y8tEX08mbiKqslriNeClnFek
 QcDw==
X-Gm-Message-State: AOAM533n/y72kDKhRFMjaIhG3OGQm6XUbK6Is8M9CePbymrUfbzIxqsg
 u9pFijCQ6IMhoQhu34Wqmaon9nRo8MukK9cN/VAChfL0
X-Google-Smtp-Source: ABdhPJyuTErRcFxpzMkUsL68RoYVEZ/vpCGT/+6SehbIGwUTjxQD1zZHXLLMW6498ToHFflVnOn3cJ/gTqAAjaVT87U=
X-Received: by 2002:a17:90a:bf85:: with SMTP id
 d5mr2012685pjs.210.1627634900888; 
 Fri, 30 Jul 2021 01:48:20 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Fri, 30 Jul 2021 10:48:10 +0200
Message-ID: <CAD=4a=WfpGqCD-kapdDCFOLVkdUo_Brb-UfnG==5T0ScSoiihw@mail.gmail.com>
Subject: Gmail throws all mailing list mails from amd.com in spam
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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
Content-Type: multipart/mixed; boundary="===============0551377616=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0551377616==
Content-Type: multipart/alternative; boundary="000000000000176f3f05c85348d8"

--000000000000176f3f05c85348d8
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that this has been going on for some time. I guess this is
because of DKIM?
Not sure what can be done about it. Gmail is quite persistent about it.

Regards
//Ernst

--000000000000176f3f05c85348d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-fam=
ily:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">I noticed that this has been g=
oing on for some time. I guess this is because of DKIM?</div><div class=3D"=
gmail_default" style=3D"font-family:arial,helvetica,sans-serif">Not sure wh=
at can be done about it. Gmail is quite persistent about it.</div><div clas=
s=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif"><br></=
div><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">Regards</div><div class=3D"gmail_default" style=3D"font-family:arial=
,helvetica,sans-serif">//Ernst<br></div></div>

--000000000000176f3f05c85348d8--

--===============0551377616==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0551377616==--
