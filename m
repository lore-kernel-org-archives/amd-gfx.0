Return-Path: <SRS0=0KW4=ZY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A96C432C0
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C549D20748
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Dec 2019 12:28:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C549D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1ACE6E1B3;
	Mon,  2 Dec 2019 12:28:28 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C95FA6E1B3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Dec 2019 12:28:26 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id c14so19404900wrn.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Dec 2019 04:28:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language;
 bh=3vC0egWTj+/NodQX1CnAUjSHyWY9A+a5hJEHalJsSrc=;
 b=AVX6HTCUZo9JUOZhIanRi2hfFuoe3G6E8CP7eEYVSUteQTADPZP6RogxHBEy2UbyPn
 zr9tkR9pLWxABL7yeB153qoccgtS5KutAPDY1qwmQlt0mxq6pODZ8YQgb04hanAsvIOT
 dv9gigExbSko57NgQpMQ/sCYF0GkY2wBFbJVKFgVY6ARMtSKJeRYKlRyX0QSzEI5p4T8
 2ce0QoDGx7wCICFlBpBWH0K15I7B3WrNbg3VlezyWI/FJ96tXjl7D7WtLr8tTEdRNVrr
 s74sgl/RsTHFqRzA0MjdmEuxCz2ur3UtC5XqIfJ1CcF6c1ELamgIn8W05WxNUHi+Rh72
 IcjA==
X-Gm-Message-State: APjAAAUGSz3M45Wa+XXNeDA/uRr517V6BMcHBZ/vxlNJi9HkZ5WlEV9u
 oxBxk53AN+lHr/bGVfr0cYtqnQKk
X-Google-Smtp-Source: APXvYqwJ198u1ho+ZNIW/Hnysn2loo/KGml+Z8YsFV2SJnVIFLAp2u1xP6r3IrFWe25opVJGpmSj+w==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr1108578wrm.210.1575289705330; 
 Mon, 02 Dec 2019 04:28:25 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id d14sm27274242wru.9.2019.12.02.04.28.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 02 Dec 2019 04:28:24 -0800 (PST)
Subject: Re: [error] Drm -> amdgpu Unrecoverable Machine Check
To: =?UTF-8?Q?Yusuf_Alt=c4=b1parmak?= <yusufalti1997@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1b8f92ae-6faa-49a4-8b38-6bccec006b68@gmail.com>
Date: Mon, 2 Dec 2019 13:28:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com>
Content-Language: en-US
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=3vC0egWTj+/NodQX1CnAUjSHyWY9A+a5hJEHalJsSrc=;
 b=StxQyWB4+19SvUApRxoYwm+pngJVGuQKpp88B8FkscznUPM1Vjyo9xXRB2A2D6STt/
 mwd64T18OWXREPSOOhuYfR3m7OwVkSsnhgRol1Cq7SP6m7LS15zcTwUa1N8Sd2SK5bW9
 SedOYcOL6BG5//ltWE4MVXAklCFaaE11AxujEiZFMYJClnJ6odWEK4Z1eNE8G6hYb+uP
 DnhLh3BnA9u6aNeeeZVCbgaanE6E8FnaYPuXr78hU1DrSx2XmhS5PiIs1aAU0X9TtWXh
 5Thkn/FAVWVxyofte5iKEg12wtMKb3r00mnDOYc12xepdSlkJT9KfUnbI8YTyhwfrKUd
 49UQ==
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: christian.koenig@amd.com
Content-Type: multipart/mixed; boundary="===============0451729614=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0451729614==
Content-Type: multipart/alternative;
 boundary="------------AFE9E9E19F6FF3143C15FD95"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------AFE9E9E19F6FF3143C15FD95
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Yusuf,

Am 02.12.19 um 12:41 schrieb Yusuf Altıparmak:
> My embedded board is freezing when I put E9171 on PCIe. What is the 
> meaning of Unrecoverable Machine Check error about GPU?

Well see the explanation on Wikipedia for example: 
https://en.wikipedia.org/wiki/Machine-check_exception

In general it means you have messed up something in your hardware 
configuration.

> Could PCIe settings in .dts file cause this problem?

Possible, but rather unlikely. My best guess is that it is some problem 
with the power supply.

> If it is, is there any sample PCIe configuration for E9171?

The E9171 is just a PCIe device, so the dtsi is actually rather 
uninteresting. What we really need is a full dmesg and maybe lspci 
output would help as well.

Regards,
Christian.

> I attached my dts file.
>
> System is working fine when GPU is not plugged in.
> *
> *
> *This is the last console log before freeze:*
> [drm] amdgpu kernel modesetting enabled.
> [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987 
> 0x1787:0x2389 0x80).
> [drm] register mmio base: 0x20200000
> fsl-fman-port ffe488000.port fm1-gb0: renamed from eth0
> [drm] register mmio size: 262144
> [drm] add ip block number 0 <vi_common>
> [drm] add ip block number 1 <gmc_v8_0>
> [drm] add ip block number 2 <tonga_ih>
> [drm] add ip block number 3 <powerplay>
> [drm] add ip block number 4 <dm>
> [drm] add ip block number 5 <gfx_v8_0>
> [drm] add ip block number 6 <sdma_v3_0>
> [drm] add ip block number 7 <uvd_v6_0>
> [drm] add ip block number 8 <vce_v3_0>
> [drm] UVD is enabled in VM mode
> [drm] UVD ENC is enabled in VM mode
> [drm] VCE enabled in VM mode
> ATOM BIOS: 113-ER16BFC-001
> [drm] GPU posting now...
> Disabling lock debugging due to kernel taint
> Machine check in kernel mode.
> Caused by (from MCSR=a000): Load Error Report
> Guarded Load Error Report
> Kernel panic - not syncing: Unrecoverable Machine check
> CPU: 1 PID: 2023 Comm: udevd Tainted: G   M  4.19.26+gc0c2141 #1
> Call Trace:
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------AFE9E9E19F6FF3143C15FD95
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Yusuf,<br>
      <br>
      Am 02.12.19 um 12:41 schrieb Yusuf Altıparmak:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div>My embedded board is freezing when I put E9171 on PCIe.
          What is the meaning of Unrecoverable Machine Check error about
          GPU? <br>
        </div>
      </div>
    </blockquote>
    <br>
    Well see the explanation on Wikipedia for example:
    <a class="moz-txt-link-freetext" href="https://en.wikipedia.org/wiki/Machine-check_exception">https://en.wikipedia.org/wiki/Machine-check_exception</a><br>
    <br>
    In general it means you have messed up something in your hardware
    configuration.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com">
      <div dir="ltr">
        <div>Could PCIe settings in .dts file cause this problem?</div>
      </div>
    </blockquote>
    <br>
    Possible, but rather unlikely. My best guess is that it is some
    problem with the power supply.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com">
      <div dir="ltr">
        <div> If it is, is there any sample PCIe configuration for
          E9171?</div>
      </div>
    </blockquote>
    <br>
    The E9171 is just a PCIe device, so the dtsi is actually rather
    uninteresting. What we really need is a full dmesg and maybe lspci
    output would help as well.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAGzVRjxGE5p3AVQf=dm4ubBrKgbTagr4QrUJo=bPmueNSyjecw@mail.gmail.com">
      <div dir="ltr">
        <div> I attached my dts file.<br>
        </div>
        <div><br>
        </div>
        <div>System is working fine when GPU is not plugged in.</div>
        <div><b><br>
          </b></div>
        <div><b>This is the last console log before freeze:</b></div>
        <div>[drm] amdgpu kernel modesetting enabled.                  
                                     </div>
        [drm] initializing kernel modesetting (POLARIS12 0x1002:0x6987
        0x1787:0x2389 0x80).  <br>
        [drm] register mmio base: 0x20200000                            
                             <br>
        fsl-fman-port ffe488000.port fm1-gb0: renamed from eth0        
                              <br>
        [drm] register mmio size: 262144                                
                             <br>
        [drm] add ip block number 0 &lt;vi_common&gt;                  
                                    <br>
        [drm] add ip block number 1 &lt;gmc_v8_0&gt;                    
                                   <br>
        [drm] add ip block number 2 &lt;tonga_ih&gt;                    
                                   <br>
        [drm] add ip block number 3 &lt;powerplay&gt;                  
                                    <br>
        [drm] add ip block number 4 &lt;dm&gt;                          
                                   <br>
        [drm] add ip block number 5 &lt;gfx_v8_0&gt;                    
                                   <br>
        [drm] add ip block number 6 &lt;sdma_v3_0&gt;                  
                                    <br>
        [drm] add ip block number 7 &lt;uvd_v6_0&gt;                    
                                   <br>
        [drm] add ip block number 8 &lt;vce_v3_0&gt;                    
                                   <br>
        [drm] UVD is enabled in VM mode                                
                              <br>
        [drm] UVD ENC is enabled in VM mode                            
                              <br>
        [drm] VCE enabled in VM mode                                    
                             <br>
        ATOM BIOS: 113-ER16BFC-001                                      
                             <br>
        [drm] GPU posting now...                                        
                             <br>
        Disabling lock debugging due to kernel taint                    
                             <br>
        Machine check in kernel mode.                                  
                              <br>
        Caused by (from MCSR=a000): Load Error Report                  
                              <br>
        Guarded Load Error Report                                      
                              <br>
        Kernel panic - not syncing: Unrecoverable Machine check        
                              <br>
        CPU: 1 PID: 2023 Comm: udevd Tainted: G   M            
         4.19.26+gc0c2141 #1          <br>
        Call Trace:                            <br>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
    </blockquote>
    <br>
  </body>
</html>

--------------AFE9E9E19F6FF3143C15FD95--

--===============0451729614==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0451729614==--
