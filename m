Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D99FCC6B1D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD50010FD97;
	Wed, 14 Oct 2026 12:50:38 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0A2D10FDA7
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:50:32 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-33e623bd651so478826eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 05:50:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982232; cv=none;
 d=google.com; s=arc-20260327;
 b=rso8P61kYADs0shs4qI9CQVLrbmbGUfKicvAuyO8HhjI1hFMYrBea/wJdkCI/4Sb5F
 B9kvGzKuSy8bSfdoBqEb/5bQiR9g4dZoEeMMikDUSXxMXTAznvWeYrlN+uYZk5jIJEeY
 P5NwFyyepS1pSg9tjkk3p0HB5FETzazF7XUx9jneIaiDsHvBR4x5TMUPblm5l+Ib6Tnc
 3hniDCMjVkObDkPG2PpENrByar2lVoHQynpwazffHOkmfTh52+qYU9uSNvvzM8CC0AOT
 VmlDN4X/fk92F/ymYTohp0MlUjOYv0T1UH3/dERD05exxM4WMJcJUl2WTnh3XXEvMqUt
 Sngw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PhlUGYQSiJOD7XWYcV4U3xmcN00jp0bFuWBDWk7fAo0=;
 fh=KFfBNDc3mKB33wWaQMhiElKWPfE3nvvrTuac2Kcie2c=;
 b=VnyLHSstJ7BPPC30n29fiZQtnOf6cbthndAXb8xQkt2iVzqY2SZXIZMCEFsoeCBsPG
 9u0P59u+2DrkD3Eq9WA74JGnOYkC9dDKvcmUiIF+wz+OTLz1Yr3T3xtKcpM0/RmNRYUv
 KZKGQ4vD9iBgGcCagIea/75CV+S9edOzyFpLuReBI94Jv7oI9ZSSOgRRmgZMAiiJXCi7
 92g4FjectpZceqf7Jht2hn3TR/1C7U/5uZze2y/LsGIwqYGgUAhfZCkq3+703SIM8vdy
 GB1D3ZkTjq/BE+BI1l1u9VRr7qIqFjCyz7K0kSeuf49FrTkkCVFR64hjb8S8ZB+oXK/4
 +PPA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791982232; x=1792587032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PhlUGYQSiJOD7XWYcV4U3xmcN00jp0bFuWBDWk7fAo0=;
 b=FBFIEJhfkzamj7RCRYugE+ihZ+69hwrrEm0/prMd8cgS7lRTGKVB8rpGXxarus2TwF
 RMx5rHED0jHQK93/xEqCW7Y+IVBDQIAOT2ZeYNTFxq9V3zA9V6snx191B0ahnVDVQ3dn
 Nb610Lcyuu61aoZkrblS4+ZRPfpg93XsyVu9t4Jof+CV9ruWZkVBTwWQf3SwH8dnwJof
 oCIVqHNhunxJja3pPEXFSIsW9Joyup88N00acb/+pzRWjCnf5D4btJuPXirjpY5Sa6aI
 86KpgA1aYjgckNmoXMwi6fIBjZ24x15zueLH88OP0hrdIiwvWCzaJ7aC6iqxjnuFalPz
 JBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791982232; x=1792587032;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PhlUGYQSiJOD7XWYcV4U3xmcN00jp0bFuWBDWk7fAo0=;
 b=CENIu/XQzDT513wmq+5xiDHWvGD/j3sx4q8obE2koYlndYMnd9eyl219vrTaBhFpdt
 YCQK9AV8mlm/G0AIZ57g5/9pTvER5FcCOXHm/YIncg9IBMiFitKsfWFnm5QeT/igaAKR
 PbaY67oTPDihp87loimGByml1yDAKErvFvfP9Hvii2t9QzMoNI0Qy4weqraJECTNIw8h
 ZiDpd+DHp1n6Hi6rCYik+4csAiZOlqbCY0IfppxB1TSxbDxUwaTXnCsVe9yM+YxQ9+qM
 HBbS5dFrOPVotXlNZAfnNjyCJAFaDj98oOkzlNyPS6rber74nNIYFYWus4tGQbyl+TxN
 GhAA==
X-Gm-Message-State: AFq9FYIT/FZL/x/w1S73YXYp2V19RU1FRITNJAM/dPUSVcbvhBu2TXRJ
 mSfZN2KDXPQZex353BDRKM+wN1Ybad3ftm3d6LV6jxeCs5zKqBs4VSDiMeBKScLzT8im+lrnCak
 4/7sxJA+jhJ4+mPZv3iA7YDeRIkmtds5xjqvu
X-Gm-Gg: AYBFou3su2leAeANdFlnYNliWz8xIN6s2SobUuDj/nIyCRfPRD3mofgsEOXrr5j+Cra
 2RZ7pO4YRJ5YLOrzhhSMkkMh53QTnGmbX4pfutx+0m/cwxbzqeV/h5ZMqPyxBJI6LlZG0V9cyQ+
 eA18B8K3mV+yL9/h2Rgx5idThHO+asSc6B9dB9R5yRWB98aNrfgsXLahAQo5AhMsUHttXiz6jKy
 VVHSHYRI+z1KEKAnDF7+VJZOAaqaZ6RufC77uEoxlVHDggir2BCwDKlT5oSWpIQJaO6mD1im5kv
 hRiofixOhjuFgvD8KxGJTb7KuD/xnYMY0r72g0K7Hw4onA8Mp6tmi+6LzF78+r+aP76Zd9i1CWE
 8NbfrEI5P72rwuvAqOU+jbK5dOiHjFhJdnM/GkUG8qw==
X-Received: by 2002:a05:701b:4511:20b0:165:be2f:c56e with SMTP id
 a92af1059eb24-16a5ce97e25mr34421686c88.2.1791982231582; Wed, 14 Oct 2026
 05:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <85a4ogwjox.fsf@rostovtsev.org>
In-Reply-To: <85a4ogwjox.fsf@rostovtsev.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Oct 2026 08:50:19 -0400
X-Gm-Features: AclHuK9a-M7-7zidbCllKSGw7zwEXLL_2-ivE0OPiNF9ykMC4T8EvRJSJMhT6Wg
Message-ID: <CADnq5_OQK-z-H1z-=K84E6nrraiFbOyh9E2-KP0uE=jm1RNzUQ@mail.gmail.com>
Subject: Re: Can xf86-video-amdgpu be used as a replacement for closed-source
 AMD firmware?
To: dan@rostovtsev.org
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 14, 2026 at 8:46=E2=80=AFAM <dan@rostovtsev.org> wrote:
>
> Hi XOrg / Freedesktop,
>
> I would like to avoid using any closed-source AMD firmware if
> possible. I have a Radeon R9700. Does the xf86-video-amdgpu library
> offer a solution?
>
> The README says:
>
> "xf86-video-amdgpu - Xorg driver for AMD Radeon GPUs using the amdgpu
> kernel driver"
>
> but I can't tell if the amdgpu module and the associated closed-source
> firmware blobs are actually necessary. I've checked the following
> sources and failed to find a clear answer:
>
> - https://www.kernel.org/doc/html/v4.11/gpu/drm-internals.html
> - https://www.x.org/RadeonFeature/
> - the xf86-video-amdgpu source
> - the kernel source, particularly in: drivers/gpu/amd/amdgpu
> - https://lists.freedesktop.org/mailman/listinfo/amd-gfx for related
>   questions
>
> I'm particularly confused by the inclusions of "amdgpu.h" in the
> xf86-video-amdgpu source tree. Looking at src/amdgpu_probe.h in
> xf86-video-amdgpu, for example:
>
> ...
> #include <amdgpu.h>
> ...
> amdgpu_device_handle pDev;
> ...
>
> The "amdgpu_device_handle" does not exist in xf86-video-amdgpu or in the
> kernel when I search with grep. Where is this handle coming from?
>
> Any response is greatly appreciated!

There is no way to use the GPU without firmware other than as a basic
console using the pre-OS framebuffer.

Alex
