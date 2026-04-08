Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E462CE9DE71
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Apr 2026 08:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB48110E7AE;
	Thu,  9 Apr 2026 08:45:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rjckayqb";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCD068826D
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 15:34:34 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-66bd3d05e03so6832206a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Apr 2026 08:34:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775662473; cv=none;
 d=google.com; s=arc-20240605;
 b=GjN2fvIQqRSA5R4tEzUGNCB35Eu0DqL8MXdS8T/GXyDn81ia5Cqpk4wFNuEWUqG4Ox
 qNZwlN6dkdAQdSyAc0yWLrPUE10Ca0NPM++gkL2+DnBHd2IN2fgIEJtpaknYq0fCyrMl
 wLstSk+K4ugnZopBLO83qsIpVTK6rxwZfFkkURB3LgMVUJ2ZOtdPPRPgCpFJ9Wc0VIk5
 BeTmH0+UwfeM06QWaC41IXkAMVoAXXaOHSaC0g8sXs2Zf4cTmp9al/7qoIUmVw4Q0gRV
 OMRvZ33p4rwNFrwaSqSLPV+ZL6G7Lbv/f7uLLmjoleU9vAN21cohcJ6F1905MGHvsGRe
 /Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=TOnsDS86e7FMFQFGNsfI+h1ps03DMdtx2CCKyEj/qy8=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=XGQbk7fHcjN4qz+OpeCcZl2bvyfaeQSeSVAmmM8iEZkPxlNx1o741GG4YKo4HtJNnz
 DGqA3orz1k4tdAMRxO+LpZLdOcSJdR71MIY3kGJl/08pvquhLANt9XXiPgYNQJ4dbJlK
 IFOGjDGTRlimHmjHr7d9v/JX4XZqT0CmhCsX2lyAmOM1QVQaw5Yz6eqrFoLjJ4/KD45Y
 s/JiLIba2pHaYnOGHOZ6+8F3tU6ImVsaFitjqezEOlCJglarylptjR29/XPaTT9Lxd0v
 6mO3+sKn13dqLuAA9Obrjofgv08F+BIkLMSvKRsltkTXOlqIbJmu87aDv+QZ/QJu/9oq
 uvpQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775662473; x=1776267273; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=TOnsDS86e7FMFQFGNsfI+h1ps03DMdtx2CCKyEj/qy8=;
 b=RjckayqbrD8SU5WEVPcGajAZqEEBCgDehfy7MB67Yr8MHYecrqDIqgKbIJUXUNeWJ+
 KGeF3x07ChLsJWmlTj5dld5lr2/6bMRhc1eHR8q19dG9EcmGVudsYCdV6pVo06oDsfY4
 dg9H8YRvHX3qgaA0UEID7Y4WsM9svqEo1IX4FSyCs4KWge2uH5aNb9mjHUVbeHESNaFL
 daTXXlMpoDB2be3q8rQhozDXZrg6my/CBsE0ddrITsepPGATaaDRH6k8k5ERBifUHoj+
 5533L9q90pDQyEFaqGGapuoZNTO05yhIDA04ZEUiQRkYtHb3GewrE0aPWhvvC0hhNNsU
 bgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775662473; x=1776267273;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TOnsDS86e7FMFQFGNsfI+h1ps03DMdtx2CCKyEj/qy8=;
 b=DpxHrDSMs9NWagJFr45loCDhFnrbER8muGBlRSw7c8n1zs/4jzit7BAnXpZAZoA0Sp
 smfEzWopUw3NJGQga2DIVz4cmYyidL4cKCsCQwkhWmZ0I7365OCUORP0GWKkvQAuQIXS
 8OagKQVMITZ+5kfGDUMTTIUZyA3wix9ugz5Kr1I3BY38WQLDq88XT5Gh3AA9mr5jCQ1g
 h9WRRzoDtMQzk0qPCx8q4MkO5luhSVF8HFDaOYsNVZ6Fp8+0QgCzfO+p8lRgrKW/8IKU
 V7JZ9xByvLHGb3wCafGNA5EWOM5DKxslDH2urjHq3sZnVV3BuPqxv/6/fDqVVZd48JXQ
 fVzA==
X-Gm-Message-State: AOJu0YxWBZVLjV+PngI83lXvAfsHwnevhEatjaFZ0tnln4oVw23++D92
 ItDysVfGTqdJZ+pzUww9F0V/PWdkFghH7vhVzAcRj0e//YMFLyw1Bix8mAgk2kj+ig/C3puAbW4
 tu/jZuTNNMHg2iJfdn/vI/534RoDLSPGPdw==
X-Gm-Gg: AeBDievxiZhJTW9MhjViDsq6otjtDbjcnFEvNdcqb8OETY9nCvt27miykT/1JW/MR5v
 /QSLpI0r+5sRgi4fuOXQXXz+RVixkHCVGD7aedpa69SKas75XkK16iqrkqHdx2SqtJZRX/H1/Kb
 2FZsZhwa7jq5ZWns+jtg8Iv48Mi/XnVU28aZIKb9G9dM1Qfgx4vESBN1h+Kt8VTOOQOLrZnaa2f
 WshUAziXCaYLd0nslQ5kYVd2qSCUNcTPQ4Y+lIwXfZwh6cg9TNTN57/qsDBTY4+lDezpM4KZnNh
 Zu/PToOz3QMTj8CH3icc5qPg2iFPmdyWZ1t8ayY=
X-Received: by 2002:a17:906:5182:20b0:b96:996c:8605 with SMTP id
 a640c23a62f3a-b9c67450e29mr857344766b.23.1775662472551; Wed, 08 Apr 2026
 08:34:32 -0700 (PDT)
MIME-Version: 1.0
From: Kailash Chauhan <kc2264147@gmail.com>
Date: Wed, 8 Apr 2026 21:04:18 +0530
X-Gm-Features: AQROBzCSkhw3S_3mdrfnB9BHVXWHIOiuoNn-aoNSD_F6fc532EL3wWKMx1FwcWY
Message-ID: <CAMvG8quu3ka7a4a5V3A8gBBx6P9knRej6s4raRPd5wO4TVU4qg@mail.gmail.com>
Subject: Re: [PATCH umr] Add the ability to update the register/bitfield
 database at runtime. (v2)
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000eae0d6064ef4a22b"
X-Mailman-Approved-At: Thu, 09 Apr 2026 08:45:39 +0000
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

--000000000000eae0d6064ef4a22b
Content-Type: text/plain; charset="UTF-8"



--000000000000eae0d6064ef4a22b
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--000000000000eae0d6064ef4a22b--
