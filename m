Return-Path: <SRS0=Rlnb=AT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AB1C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B727D206DF
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2020 17:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPTpfzZ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B727D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 830476E8F5;
	Wed,  8 Jul 2020 17:08:55 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9DBA6E8F5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2020 17:08:53 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id f12so25135935eja.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2020 10:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F/FVPHRGWDz5gMawOje+kyeIrStFWYZnAbHcEHarQaM=;
 b=GPTpfzZ84fziUw28dc+dWis4wRTCQX/5xlZB8QsYrTOYdb/PMeIPXCaNmXzwcl9So1
 XcGfy+B2Z3Hbeyss4ttguV4YIluhQUJij1Cpg0frRrdYGyEmXKjuNV76/GMZhBpbteco
 C4H1NFJFOLUlsZtZv1AVpd/3kZ20NioVL9YsnFfx5aSH8D1HhD8JpmBszApafzmbt+vS
 tA+qfJudtZspDaCMqHgGzatp8/jBYlTsYbI16bDGHGreh4fuojr+UOs9kbPiBojXnUsH
 9Xm7KGwwLROJXFEoKq02j/PL6ZJcRMZv/Oxz5T/AjlLqgxI8ny34xn+41b7MbU6glIhI
 6K8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=F/FVPHRGWDz5gMawOje+kyeIrStFWYZnAbHcEHarQaM=;
 b=U6eWLuNqypzZ7zjyQtC2T34lT22YUDuh78zhuKSwn6t0Zmr00XeUvXBFGSu+6Jm9Pa
 GRa3GCiA/Cd7d9xalT1m64cLBQrHsK4ghtQlUN5rQbbtBIapt6tsGyvBnHpoKKCAdrvz
 Nlhzs8rCxepBtoQv+79NWvw6/fjV3U2GRl40f7fFEljrq3aeBT+vt8piH80HidtIbF+u
 r4XL7HWRvNapg22gLrjzzXIf7pkxqwPn7lmGd12B7OuQ9dmBMyyGVB/JNN4e7bml9r/z
 AlTZJb3ycBmezo57i1Jw23GMHJv1PgQEqtW4lokorSdl3rt7o1Io/992LwoVRrRfxd5f
 WajQ==
X-Gm-Message-State: AOAM531ZiQ9L4gb9UaOPU5qFVR/7kQsTSST4mxzkE0aU4jYjP4QuffDZ
 34+9hUvOPdzqQ67YT0gDF4yxGRxZH58=
X-Google-Smtp-Source: ABdhPJw+TatAhSvM4kt0rzsuLdcSu95dXGJXBVb2pSF2S0ZZftsZ4BRy2wkvKV6tdHSTYXjnxCNaSA==
X-Received: by 2002:a17:906:94c4:: with SMTP id
 d4mr51272856ejy.232.1594228132482; 
 Wed, 08 Jul 2020 10:08:52 -0700 (PDT)
Received: from saturn.localnet ([41.182.130.16])
 by smtp.gmail.com with ESMTPSA id cq7sm93162edb.66.2020.07.08.10.08.51
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 10:08:52 -0700 (PDT)
From: rigo.reddig@gmail.com
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Linux 5.7.7 complete system freeze
Date: Wed, 08 Jul 2020 19:08:49 +0200
Message-ID: <3564679.7nI7lTb4kJ@saturn>
MIME-Version: 1.0
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
Content-Type: multipart/mixed; boundary="===============0397974370=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--===============0397974370==
Content-Type: multipart/alternative; boundary="nextPart2257869.EM3LvLAjl0"
Content-Transfer-Encoding: 7Bit

This is a multi-part message in MIME format.

--nextPart2257869.EM3LvLAjl0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I get complete and total kernel freezes that result in an entirely unresponsive 
system. This issue as driven me entirely insane since it happens at random. It has 
cost me lost work on my machine and I haven't the energy to further 
troubleshoot, since it took me ages to get just this kernel dump via netconsole 
(which didn't always print before dying).

System is a 1700X with 2X GFX 803 (RX580)

[ 2203.126193] general protection fault, probably for non-canonical address 
0x93e3cc5d552d69c3: 0000 [#1] PREEMPT SMP NOPTI 


Best Regards
Rigo Reddig


--nextPart2257869.EM3LvLAjl0
Content-Transfer-Encoding: 7Bit
Content-Type: text/html; charset="us-ascii"

<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body><p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">I get complete and total kernel freezes that result in an entirely unresponsive system. This issue as driven me entirely insane since it happens at random. It has cost me lost work on my machine and I haven't the energy to further troubleshoot, since it took me ages to get just this kernel dump via netconsole (which didn't always print before dying).</p>
<p>&nbsp;<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">System is a 1700X with 2X GFX 803 (RX580)</p>
<p>&nbsp;<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;"><span style="font-family:monospace;"><span style="background-color:#ffffff;"><span style="color:#000000;">[ 2203.126193] general protection fault, probably for non-canonical address 0x93e3cc5d552d69c3: 0000 [#1] PREEMPT SMP NOPTI </span></span><p>&nbsp;<p>&nbsp;</p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Best Regards</span></p>
<p style="margin-top:0;margin-bottom:0;margin-left:0;margin-right:0;">Rigo Reddig</p>
<p>&nbsp;</body>
</html>
--nextPart2257869.EM3LvLAjl0--




--===============0397974370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0397974370==--



