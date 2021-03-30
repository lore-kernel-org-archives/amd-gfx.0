Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A22CC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:41:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C9C6619CB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C9C6619CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BF46E8F1;
	Tue, 30 Mar 2021 13:41:34 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF5B6E8F1
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 13:41:33 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id u21so24852113ejo.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 06:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=8oudpem19PohN/k7E8KrGTUPZ8yH5cf6zksSfpZCkhs=;
 b=uPLAuFbqdy178bBSBj84oOLjvnucAABshkG1Z50y56yi82ijeAa51G1dEhFvatU7h4
 UrmNPl0rUHa6rMk7ORAJeklmwE1ew/O+fRlJ7GtJ3kEx0i+2g+8iLLt4rq2bY+ZeV0P/
 RoPelhcMXAvyPJDSHxO3+l3VwmL60bs+TB5q6QlARIBdVf5yR5uySwijj35/gwV5HREh
 Anu+3XXJjsGdPwWW2n50L3wIAbaZQ9/cRA2h5sxIStisxoiTZfeIIXDDOKvW+3EvnwmM
 rF1l54KRG/SYAXljjzEEUEaIJjY+Pb9zyJOY0BTxgD9VO3sta1M6ZlD0xkEg3SAAwWvm
 mO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=8oudpem19PohN/k7E8KrGTUPZ8yH5cf6zksSfpZCkhs=;
 b=f1ciejyUhp1hgShfc+kLfhQRZKC63hQ1E6bXSWsHmEo3RDvL6TNA6WnOMbfV2s5tpr
 ANPBE/Jq3KjGe0U8HZA7W4V/KIWnacwGhpSKaKsohe0pEqGAwgH3R3EI/zaQTJpTEvAV
 0FvUdn3qYgBWvMj/R2c13MVNhm3n7h6vcmRSHJqo6DpxDG29dKsPJK36KkY9jtLViAVi
 bw4ZfUoeewFA5hOsz2L2O+QBo3BDsqWe0xuSY4/88BG3aJsmrh0Y+1uVux7RPA1cZI9M
 r6Ok9NzIUGPbCneRbsbHkiT7MOabFjSDPcaZy7N4ELQjZressbopkpWCfz9hFf5jTimH
 mnFQ==
X-Gm-Message-State: AOAM530XGusKNiuP3JB9P4WJhp8XMWcyTVBLEUqs+AiRpn8ztGiSScHp
 i2HB8bdvTLztIOoPINR6r3IEgsNfy64=
X-Google-Smtp-Source: ABdhPJwFWYyKH3ml5xGKFIQEypQU3A/iSh5bDGjmfWv154+c/77XTxf1p2feIdVkFtgHHQsPAgVDvQ==
X-Received: by 2002:a17:906:2759:: with SMTP id
 a25mr33901611ejd.122.1617111692711; 
 Tue, 30 Mar 2021 06:41:32 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:8ca4:a46e:6aa7:208c?
 ([2a02:908:1252:fb60:8ca4:a46e:6aa7:208c])
 by smtp.gmail.com with ESMTPSA id n16sm10077944ejy.35.2021.03.30.06.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Mar 2021 06:41:32 -0700 (PDT)
Subject: Re: Interlaced resolutions hang the desktop
To: Alberto Salvia Novella <es20490446e@gmail.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
Date: Tue, 30 Mar 2021 15:41:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
Content-Language: en-US
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
Cc: alexander.deucher@amd.com, benh@kernel.crashing.org,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0471254215=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0471254215==
Content-Type: multipart/alternative;
 boundary="------------99459D51C144C936633E3453"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------99459D51C144C936633E3453
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Mhm, no idea why an interlaced resolution would cause a crash. Maybe 
some miscalculation in the display code.

But apart from that if you just connected your PC to a TV I also 
wouldn't recommend using an interlaced resolution in the first place.

See those resolutions only exists for backward compatibility with analog 
hardware.

I think we would just disable those modes instead of searching for the bug.

Regards,
Christian.

Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
> I guessed so.
>
> The GPU is a Radeon HD5870, and the screen is an old Telefunken TV 
> (TLFK22LEDPVR1).
>
> Since my real display got into repair I used this TV meanwhile, and to 
> my surprise it froze the system.
>
> On Tue, 30 Mar 2021 at 10:15, Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Hi Alberto,
>
>     well what hardware do you have?
>
>     Interlaced resolutions are not used any more on modern hardware,
>     so they
>     are not well tested.
>
>     Regards,
>     Christian.
>
>     Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
>     > The entire desktop hangs after some minutes when using the module
>     > "radeon" with an interlaced resolution.
>     >
>     > Easier to trigger by playing a video on Firefox, at least on
>     kwin_x11.
>     > Wayland didn't exhibit the problem.
>     >
>     > Other display drivers, from different computers I have tried,
>     didn't
>     > allow those interlaced resolutions all together. It seems they know
>     > there will be problems.
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------99459D51C144C936633E3453
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Mhm, no idea why an interlaced resolution would cause a crash. Maybe
    some miscalculation in the display code.<br>
    <br>
    But apart from that if you just connected your PC to a TV I also
    wouldn't recommend using an interlaced resolution in the first
    place.<br>
    <br>
    See those resolutions only exists for backward compatibility with
    analog hardware.<br>
    <br>
    I think we would just disable those modes instead of searching for
    the bug.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 30.03.21 um 11:07 schrieb Alberto
      Salvia Novella:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>I guessed so.</div>
        <div><br>
        </div>
        <div>The GPU is a Radeon HD5870, and the screen is an old
          Telefunken TV (TLFK22LEDPVR1).</div>
        <div><br>
        </div>
        <div>Since my real display got into repair I used this TV
          meanwhile, and to my surprise it froze the system.<br>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, 30 Mar 2021 at 10:15,
          Christian König &lt;<a href="mailto:christian.koenig@amd.com"
            moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi
          Alberto,<br>
          <br>
          well what hardware do you have?<br>
          <br>
          Interlaced resolutions are not used any more on modern
          hardware, so they <br>
          are not well tested.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:<br>
          &gt; The entire desktop hangs after some minutes when using
          the module <br>
          &gt; "radeon" with an interlaced resolution.<br>
          &gt;<br>
          &gt; Easier to trigger by playing a video on Firefox, at least
          on kwin_x11. <br>
          &gt; Wayland didn't exhibit the problem.<br>
          &gt;<br>
          &gt; Other display drivers, from different computers I have
          tried, didn't <br>
          &gt; allow those interlaced resolutions all together. It seems
          they know <br>
          &gt; there will be problems.<br>
          <br>
        </blockquote>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------99459D51C144C936633E3453--

--===============0471254215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0471254215==--
