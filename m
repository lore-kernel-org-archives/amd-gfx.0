Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CF9C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 418BB6124B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 418BB6124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B486E147;
	Wed,  7 Apr 2021 02:37:10 +0000 (UTC)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 956866E075
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 01:19:23 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id n4so8022611ili.8
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Apr 2021 18:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XescJoWvjtEUyS3sb+mdCiQLxkbOaZnxo6Dblh1yBvc=;
 b=U8f+oFuMCjpa3OLFwQvN+IiTxnfTghsve1ipCso5rXGKvBAk8LG7vExHLZy7rz649j
 GO7Kb3Nr86VI8+6DCJtXaFufBdd63iS9sHn3kRQFMHIOo9H8vz//Rv1wJd+O37FhrJq5
 1yOYVgkBl9TvZ8MvzD5Ww4MRO/gk1efIl8qQucQDjq2vcHs72nXr+aFy/4mnLzcgcnj1
 FrW4Vb5e5IoTpOUUo3a0t/k6SWGCW7ZJ3zxu7bRHyiVG8G0xfhhlLQnoMN7vm9VXSTFH
 CS4KAHJP9c/TWpxOLByp30Qc0sjHe/rGLxeXw76nbVPxRUS+z7gJL1qLuAP/t75Icr5c
 /buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XescJoWvjtEUyS3sb+mdCiQLxkbOaZnxo6Dblh1yBvc=;
 b=hP6AkAhbdm+zvTy7xrThSfIL1+cvwZo7oupolRWIm0upu99o86Hr7rdMzIYO5H3ymK
 vNVkOUgybBy7y9bq15CM28aS3eBtEsSajZEq+63x6Tb0jmoc5wO5qpitQJ3n/fV4AAKq
 RXL4TWqsrQismHnhVasDf0QSzHDqIjbo9acZP+brTw2HpQ1dDkoSn6fRKQPo/uA+UdlF
 HC1JSkn5ewSJFDuPzUtuBz0JEljQQCLuOjOn6kakcRxED3N1zsMeVVWBPWGj/h3fSn8A
 IxVSJiGPTYCy2JBbN7MTEKG6ZR2FZH7ktdGgL7rwFqr4kmuA3lM+b8AACmpfCeXaXasb
 alVg==
X-Gm-Message-State: AOAM530rhSv8ZDPvi9bfsocjrx6QH0oOTHp2IXPwOYCj93g87UFlI7b7
 eWVnINhTWZBtAC3gYYohxbBKmb0X6NXq/8dkhc+6VXIQ+mM=
X-Google-Smtp-Source: ABdhPJy+VkiAxCTfPdwI/AxT0vxmy6Bt93biqEAhvRxE1Ktl4XW9Dc7165/U24znfRtp8vDOF8027sDMGPKB0wpWp3c=
X-Received: by 2002:a05:6e02:198f:: with SMTP id
 g15mr822616ilf.200.1617758362826; 
 Tue, 06 Apr 2021 18:19:22 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?2LXYp9mE2K0g2KfZhNmF2LPYudmI2K/Zig==?=
 <almswdysalh404@gmail.com>
Date: Wed, 7 Apr 2021 04:19:11 +0300
Message-ID: <CA+jaEHV2ah_MK0+1Sv0y=x3Qj_Q6m5SxR=wY99-dyyHuhOrURw@mail.gmail.com>
Subject: Re: a quetion about buffer migration for user mapped bo.
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 07 Apr 2021 02:37:09 +0000
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
Content-Type: multipart/mixed; boundary="===============1730367098=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1730367098==
Content-Type: multipart/alternative; boundary="0000000000008c7d7405bf57b81f"

--0000000000008c7d7405bf57b81f
Content-Type: text/plain; charset="UTF-8"

771763840

--0000000000008c7d7405bf57b81f
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><br><br><br><div data-smartmail="gmail_signature">771763840</div></div>

--0000000000008c7d7405bf57b81f--

--===============1730367098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1730367098==--
