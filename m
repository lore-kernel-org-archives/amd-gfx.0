Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B4FC3DA7A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Jan 2023 15:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EAB010E35F;
	Mon,  2 Jan 2023 15:56:06 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E8E110E35F
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Jan 2023 15:56:05 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id tz12so67406119ejc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Jan 2023 07:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wNNKCH1WKlNf691TNsXdg/f1VvQZG85M2UH4KYxabnQ=;
 b=jEQsaQVIPtRDeyQ15zkX+1q0IU0+NTNcbouv75oHVY93W7vlwex7m+HBEteInQSh+Z
 seMDtanNrIikbIw3c9mDUWXtRHzpAPIRurtpfntLGApSzxnIQ+l0BusAg9W2t5QqhY/6
 PQY7ceY7v4OXJwR7HHBI70CJNJmSk8JSXKG7ssFuwkjuNYaPXTaJ0kJyMrSJ9eK0PbYn
 Jgh0qJKzVdPT+nUJJA1ZsOT6azopWEIH/DOqlRcx0gKRW21Q9i05R5wLS+Wb5MFDMjdM
 LE1RCkfndvCjDRLafXCORjPIF1K3GHhgJ7v7eNlePSVR4Dm9oi8DY6G5wbU8/B+/fXI9
 Y60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wNNKCH1WKlNf691TNsXdg/f1VvQZG85M2UH4KYxabnQ=;
 b=TuEoiendGLWgKrRX9rSVHpADMHo+wBziREQm6P3osAsTzNLGLqvcYZM7ThtXERJJnU
 yNk728j7flITTKYXh7gno/dcG3RNWA473vzy7/VWSuRqOwuOnRKjEPeEFu5glmWi66TD
 K1z80SKttfgorMSPgcdC7CTw0NstQUi8KGq8QO15CtVa2Mxpk74IUsRn/68UDg7SI7o4
 sN1mZvjWvPQ7LAia0wOUOr2NK1iMSt/g4+r/y5f3ouU9X45oe0TsjsTUmfvpXh3rbGRY
 XSC3ynQFLeuAEy8rksUCKdCzHHSLiLs8EX/SQ1pW2zhQ2wbx4spMzUh0dciFP++ExC+R
 Knsg==
X-Gm-Message-State: AFqh2kqZdM7zCMgTD7/CVdvUI0mfSRlxKuJHzCRaSr+fy1BEZddGO8Ll
 VXZZhVtqqdwR3m4JnyNcH+MUVhc1KsE=
X-Google-Smtp-Source: AMrXdXsK3vSMuEVbnv/ZluFmNKUlrLntpNg1xOzL2Ms2miKozRwbkXi3MACiYiODM4GYl51SslyQ8g==
X-Received: by 2002:a17:907:7f04:b0:7c1:36:9002 with SMTP id
 qf4-20020a1709077f0400b007c100369002mr44457808ejc.67.1672674964090; 
 Mon, 02 Jan 2023 07:56:04 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:8d77:4e27:bb99:9a97?
 ([2a02:908:1256:79a0:8d77:4e27:bb99:9a97])
 by smtp.gmail.com with ESMTPSA id
 gf3-20020a170906e20300b007bff9fb211fsm13116019ejb.57.2023.01.02.07.56.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jan 2023 07:56:03 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------yMNUedVwgQPzJ09sXEAm02Yz"
Message-ID: <355bab4f-2ca8-3dd2-4cbc-264931fe9d7a@gmail.com>
Date: Mon, 2 Jan 2023 16:56:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] drm/amdgpu: add AMDGPU_INFO_VM_STAT to return GPU VM
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------yMNUedVwgQPzJ09sXEAm02Yz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well first of all don't mess with the VM internals outside of the VM code.

Then why would we want to expose this through the IOCTL interface? We 
already have this in the fdinfo.

Christian.

Am 30.12.22 um 23:07 schrieb Marek Olšák:
> To give userspace a detailed view about its GPU memory usage and 
> evictions.
> This will help performance investigations.
>
> Signed-off-by: Marek Olšák <marek.olsak@amd.com>
>
> The patch is attached.
>
> Marek

--------------yMNUedVwgQPzJ09sXEAm02Yz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well first of all don't mess with the VM internals outside of the VM
    code.<br>
    <br>
    Then why would we want to expose this through the IOCTL interface?
    We already have this in the fdinfo.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 30.12.22 um 23:07 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A5su09qWsCekUX4ZzTMAX+9m-BemDxqL2Hh9328Z1WDqw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">To give userspace a detailed view about its GPU
        memory usage and evictions.<br>
        This will help performance investigations.<br>
        <br>
        <div>Signed-off-by: Marek Olšák &lt;<a
            href="mailto:marek.olsak@amd.com" moz-do-not-send="true"
            class="moz-txt-link-freetext">marek.olsak@amd.com</a>&gt;</div>
        <div><br>
        </div>
        <div>The patch is attached.</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------yMNUedVwgQPzJ09sXEAm02Yz--
