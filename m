Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9796CA5FF5
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 20:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2806F10E0F0;
	Mon,  5 Oct 2026 20:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fsRC9GZ6";
	dkim-atps=neutral
Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com
 [74.125.229.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF88310E0F0
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 20:14:57 +0000 (UTC)
Received: by mail-dy2-f43.google.com with SMTP id
 5a478bee46e88-33e4e75342aso179370eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Oct 2026 13:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791231297; cv=none;
 d=google.com; s=arc-20260327;
 b=GaOsr8pLwMpT9MQBb6tmzyEjAUaMHsJUBlGMrCpLA7nKupm8erJjXLCYAsRpyy/BR6
 YmUVyBeAPF18rAO1B+gRq6RrfyZcgj5q61+JJX2XPXltP2VB8xnq6BwGrCiSBpQpTdkh
 VCUhL/6Zc4HJWZl6UtU1o0J6k5iWAAqJb1EDqCzN6WtBkAFa7M7Wel9XCgFsl3xJETwd
 MdLQ8IR/mw8s5jrPHMTdv3vIwoHGnz0eHqMuA/h9yUArLzcmoYnmlSC/BpqdUVioKtWl
 HmFYazKO9EnhQDXXd9bf5KpVFl1jWjeoNB5JPsNdl9SpV2e8Szybkye6HgJ4ckUCzrx+
 H73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
 fh=t3z07bXpE5dv597OzIs4IK4RMZbiWGP78ly0fqVN1mA=;
 b=dyPXbbknePsHY4pKCRfvVBu5Uyphav3eHAUGWkf+ojEIzfCLCRthSlQUtxauuT0AVQ
 Dgh8Q51VGGVIdK7mBb4EbQ6qFbVGJLE5URgLRaLhjOftu6OL6Ty8WyCl51D6KtdZpwKo
 UdHIZh6waMyj6rrdEv+dAdm6GcGXTW0WdckuGauG8rIyMv4sTQYvwZtfBkLDzoXDTmh6
 qDJ5keiJLa+nvQry+bNfoDx17oxvTZUnjyei1vRjNdVnHfNemB7f4Dtn5+HZYHW6x68g
 NKSdjrsMlQjCawQa2VpZeoj//XQdDdmupB7SNLukiU5meyPysQC7JUygTCXXGL/dvpIz
 D6Sw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791231297; x=1791836097; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
 b=fsRC9GZ6onTDpD8eeiwPsQx03Ozjenxi6J3475JasKl1nE2R0cmn9DnJChIfkfkK02
 k8Fv7S5Kvbpr/fbTJrPoQnwDGtz83WuXuq57/i2BOUxJLjWbF8cthjHvRWqJCRXC6TtT
 8FfqnTk0wAfbWpW4GMD7FCxuaRCS//owrYD0DN+saaidIL6O4yLa/aT1Um20zoE2O3vi
 GuOZYf5tSMtst125MM1xtElWe5RVtxgrwGtdtJEQkVHbyIqhMxFXBW37VrzPfrpOLxM8
 tYTdMLiNlMGgaKlNx66pLX5NQAaYZOXaytfL9oc3wkYhmTPIEwVRpcaGuRV/pZQ31FNR
 Z5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791231297; x=1791836097;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AMDrs/XT8ZcB40o2W5+io947QcRQ068ng6Mvjz++tqs=;
 b=BEZiwrvL/5r0rvr6mPwMacwSRbgF1VUHc6s9Gr9eMzuLkWlKoQpFEllNwrCpC8jSOr
 tWeRSM6jmeq7voMKjDLJ/JzHY9kwWUa7S0Itci0jmoUso+4FG2d35NMYcA9GPrgcQvrQ
 d1JMmKu6lZb1FqerXx0a9VAtGtJPlwgU8o7u4p5ZEYI6KLqUX5JbIbh41jul1IE4Gpi5
 q8xjsSKu6HL7e8if/y6HPHCy2kPg30V1eCmJuj0XpF4YRAMO+C3kOQ8IIeZ0Wkx2pfNO
 MEIzOBVY2MdmTZuFM52Uh3wBGbRz+rMg77AtcuvceSCUNSGFOQjJpSwvEdwlNzS2i0Dr
 OEPw==
X-Gm-Message-State: AFuF++n6NaYqUPCUE+fcWjRUtOyWTD3uS23glFoNwNgueDjmB7HEzxpC
 KvrdnNDmBxxtnVfik7WAyUyyyf7xxNaVFdrmMidSbJiBhs14eZVj4bAjhyD4p0VuMv0BwIpkRF5
 rVUO7YpmRkxKtDXEaRD2PogcLkernNjo=
X-Gm-Gg: AYBFou0hCA98GcKGG5I22P1UfzmxuZedL6WnM1dXleZYBROfyTfILiWaR9SBvO0D860
 gOHDfQPthlCXGencAKUyqakXAVOAN9NgrjTCB7JQqUySmZtoeGF6gGe5WgiXQAwDjJBIeRafgSu
 V1OZZ7DitoJV1VqvnKhhh1R9yXKfmmp3R+LjrvCJYw0WDUbdKtxdnMVdMGy17pYV0HZf0vzN24I
 tFmcj6kbUzNZOD7RGzPsOdRvO84OacaOH8D8hFpnmYeBCOKZaZRDr4pyHA51522tZf9zMXUMb28
 22PJ9Ysd1+xED/IFjOZx0C27Aqgd/3uI0ZITWY5slNswWFCZOlIQ/JU62ozGmaMn3FR3CYbSGKU
 67QjTewHo6N0W+FdQkizhoGBfMl/wtO4JLAHUyGTyyXKm9rdoVPUR
X-Received: by 2002:a05:701b:424d:20b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-14f5aa4188fmr24322303c88.1.1791231296682; Mon, 05 Oct 2026
 13:14:56 -0700 (PDT)
MIME-Version: 1.0
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Oct 2026 16:14:45 -0400
X-Gm-Features: AclHuK_EZlkeYKVOf5yOf2obDYc8_quHkQ2koc09s-PajMO3v5D25hjL-FV-od4
Message-ID: <CADnq5_MO+ZNOzW+_EH+gUYZ27X_ggWJJ0XdK6m2QW53m_ThtUQ@mail.gmail.com>
Subject: GPU initialization failure with kernel 7.3
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux PCI <linux-pci@vger.kernel.org>, 
 LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Lukas Wunner <lukas@wunner.de>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 Christian Koenig <christian.koenig@amd.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Lukas,

The following commit causes GPUs to fail to initialize on a number of
our servers:
eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal Errors")
The change reverts cleanly and the GPUs initialize fine with it
reverted.  I've filed a kernel bug to track this:
https://bugzilla.kernel.org/show_bug.cgi?id=222095
Happy to test patches, etc.

Thanks,

Alex
