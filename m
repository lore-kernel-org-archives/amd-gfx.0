Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F66082BD6
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=specialhomeeducator-com.20260707.gappssmtp.com header.i=@specialhomeeducator-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DwwaYd3z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B9A10F5C4;
	Tue,  3 Nov 2026 14:03:15 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EAD810F5A5
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 13:39:13 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b1afcd2d23so5993251a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 05:39:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793713151; cv=none;
 d=google.com; s=arc-20260327;
 b=RGfa6KU5ILTg+7hD500H8ENdq/JdP+2aNERoIZgAhOtndBVZunDCTU+Oo+ueE5fa6h
 njqviZtbw1Qsq/NvGAxrSfAv4RDeasqBUzE55cbc+vkTGc/RjwF3LrsEYdd+5xJ5zAVC
 I1QqB9sNQumAIfiE1uXgQYH7zT8PVIqep4XtJ5bhB/Vaeyg7XB3m2qF2AgUMynANOl+8
 2i5OpjYVEP0Df2bK26dYuJ+GupraGy5mvBM/7yDe1Ju9putON9INNAmb5TZwbYJfj2A3
 mBYcNMT+HWG6ZiwnfAlGq7Iq0NkHHaMjZxJVZbzSdZ+un2h3Yo/jtId0hQY4cI7gZyWc
 G/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:dkim-signature;
 bh=w7oa9u9irnrQDldieADuHy1w16xCZ8118nTPekByKYs=;
 fh=hs9oynQb3YjZT40omR8IZyt+l0QN8nu4Bye5abBVWug=;
 b=KbXcGJseWodfQMEu5IfEmZQrxlM4ifUf7sJ9cZnSlmpcaebC6Zc2xt3rJOJ3xn3hrF
 zwjf5An9rVyYB9bqo87OnAJNDR3gwvymGiuLEFFNVHrgDmOuyAZKCuaxVUBbqgQNp27B
 tleK3dT3Kgt4h+yIynC/eTRoXNTK7Bsf4+1r4gFrJWGlvs8I9TFkSRBKKHt28mdhOhJQ
 1pJCmaCM1MYOzMqCDc7nJck2Cb00oSnkxq6u7l4YkaB9JgJVc2yXsliV3FBsAKAb3aNg
 cbof7wFP5GDWMXDWV0NW9Lw2vi267mWFzax15gLXHrliGNgxRmV/e4a2NU1EeKg1kb9m
 SkfQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=specialhomeeducator-com.20260707.gappssmtp.com; s=20260707; t=1793713151;
 x=1794317951; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w7oa9u9irnrQDldieADuHy1w16xCZ8118nTPekByKYs=;
 b=DwwaYd3z4DldSDNYrVlHsj4ezIadzWqVF1qrZ4JNHYdhtkaQY/eQbAyA0BOCc+O+1T
 SmrYI/msSQHRngbHc4pVBabhDyR5fA6biAXF0kcUHgbZz55l6URU2xqwpgJoeFgJcdCW
 Ls7NEF1GWOmtNIEv33tOsEdq6GO/t8DiyG6VqeOBn2PThS9a6Y8FreBuSw590+KMqo3U
 MWRAavTQGWM86sPnHzEh6FBthEzAl+9+oB7jTgRGdcQJLkaR2D8JTB+wPNtK3vB1OPYg
 wiOC8FfAQhe+e8StdXWDub9g6vwmJ99UJppJkGcgY2egO5Mhxu303IsMguFk4OL+mDtE
 3nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793713151; x=1794317951;
 h=content-transfer-encoding:content-type:to:subject:message-id:date
 :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w7oa9u9irnrQDldieADuHy1w16xCZ8118nTPekByKYs=;
 b=gd1GZB/T5bc+p7vH5AGJdowZyO/C/jII0xr1+I+YQ2cek+dHnWAncOOkZf56Arymkp
 glNU+bBYk25/RLWKa5xJ7LUXTJOGyBVWedRfXWv4vqV/4F0ph1G+6njb6AT5Fx9/ZYfu
 YQV5BmtFLMuvtOqic5eY3fqVadoNp31H7z4RPCCsOxfl1FbcrSSRSCby/7RR93i1Mh3h
 iqn2CV2xAMWQmDmVhwxY7FKcr/c5AyAevnkxZw7p/F64UgAQVzmI3fCa2c1sy85p/LIA
 iQdhS3GMR8mDiyQE6ykx+w5BWR/u3zqZMLRZ3O+HnAAo5BlIhWiiGzZvGBO68Xweg1id
 r3XQ==
X-Gm-Message-State: APuU4Z9vN4sxGcJEeCd596ws1KYVaT4qWYiEB+JXeH2TSujTNQUyN+Cf
 Zd7EQbQlTvw3st8fURHHFJspGK7Oj+iOrURtnOjA7PfspU5jx7pJ39oingi08DygLkLFbklZaqA
 ytLFkEWZjcq4CTLhPhvhkCl2GnWzbpEewIFOPyjTdka0ISzFImyHf
X-Gm-Gg: AYBFou1S+3PmnSBSrX3ZvpEhygkGS+RlxSFQhzdlm8stvr8qNNST36tJCttXg0oH2AS
 6sM/tBflrexEjIKIbMI8zomOWMsArgSXdmdmMpu5uOoIUpcI3XyhFtkl/HDdUOYVRbSoj90IS04
 xKsdE/24mslmwJlAcZYmU2uixeN9PlTs93O2hmSa9IoLAcfKh+hNhgqpQZRFeG7XeUA27aE8lq/
 5KkY6aKHcnvsNsOvT+WiaGOeDmH8F9GMqRiMQk8jhZSpRjhKSRbZ98xijPDrWptBqqROYL4U37H
 UPMqQN4v9kkFhGY+AiXCYDMeysdBNamytVcKZUpHEOuFkCIK7ozYnDfVmbr56qIi7LX6vLQTfiq
 ONsRT9lDlsWE3HmMqJMRTF15COyip21NCkiMOsqbMa7SZSgdIgL+hdJc4ODkryQzEQg==
X-Received: by 2002:aa7:d690:0:b0:6b1:c7d9:b61e with SMTP id
 4fb4d7f45d1cf-6b4d46855d7mr6649252a12.22.1793713151392; Tue, 03 Nov 2026
 05:39:11 -0800 (PST)
Received: from 337393973955 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 07:39:10 -0600
Received: from 337393973955 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 07:39:10 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Jenny Wise <information@specialhomeeducator.com>
Date: Tue, 3 Nov 2026 07:39:10 -0600
X-Gm-Features: AclHuK80atNSYNCwV6JnUSZ9-uoeZYnRvsQkVQNJ4cXz6W27Xi4w0cn4t6aUV7M
Message-ID: <CAPsb-bp-2AiVxoEfPf=6ONTWLkqyecmt6sSDhv-LiTR8LHX4oA@mail.gmail.com>
Subject: Follow-Up on Future Planning for Special Needs Children
To: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 03 Nov 2026 14:03:04 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=1.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi there,

I hope this message finds you well! I wanted to circle back and see if
you had a chance to consider my article idea about planning for the
future of children with special needs. It=E2=80=99s a topic I=E2=80=99m pas=
sionate
about and believe would resonate with your audience.

If you already responded, thanks for that and sorry for the repeat.

Warm regards,
Jenny
