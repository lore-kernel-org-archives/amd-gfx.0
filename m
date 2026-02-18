Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1C7E9A02C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Feb 2026 23:59:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9671110E1CB;
	Wed, 18 Feb 2026 23:59:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAnjfras";
	dkim-atps=neutral
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B8C210E1CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 23:59:08 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-824b32875e7so161712b3a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Feb 2026 15:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771459147; x=1772063947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SuY5rCkQpmLiVJarlI6v0DGvJZbgFaNKx1Tojg8PoOE=;
 b=jAnjfrash+6iLu4POF0BHJOtyPoR7lBD4/VWvGXYzHN21kGzukAFijN/7sfFiM7jW5
 sKVqzGr9xgjJDTKgvhiV7lOyOxECq3lnCylaRmf0oK+iLoqWAcu3PMS9jHOgdHKt/K5Q
 02MhBu5wVv9frvlRgJKmf9VnnsrzgD35ES4EhF8fVBatpOxi/EITjNRRuGvGW/tN/lz4
 sltcxPvaMNKDP6FYEK+SQqUkCUWZVcnGtfftEyOEna7v8hupqf+MyrsgTEhpZmm8jZMx
 eFcoeCqNCTdFqAGbZa10zYwlUZHl2yiWQhHJFleXNx7JfSCS+WkxRt9vCF4C+ZTQ3gqw
 enBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771459147; x=1772063947;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SuY5rCkQpmLiVJarlI6v0DGvJZbgFaNKx1Tojg8PoOE=;
 b=JzMBEPrEEwPZZJUpJ2yfhC1YlUxy3bciXmQVq+GHRdNzgQtjdUXrOSifN7ZgVNzN1p
 jFdJ+mXCqcCLBexxR984OeXnd5mFeWLebGqd6HENg33+xFVrjY4H8WDJNxY06vMv+SbU
 +SYvc7UDYJnkIV9l5+EiAPKn88Eobs+L9ioDIhW0u6nVqoMTZSR8p7cFrSR5eBWRU2CB
 w0FzIV5Sb3iWgfes3taHcWIpk49GwnkP4SCwJmyR9r8ddn59u1x0jPTS967D6OHpPKFR
 InMk6NsP0rMGUYLroxql11EimrQfmY+KylQ91HE8NwSjHh9ny6XR0lh99+94Yv7KC+NO
 Po/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAE2bseS9ntVp1q3timxYup76Ggcgpxu0ftpR7rTo7HjgRSSjtn8MeiF0sfOYYpoLV6v1HqISi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJbiB10vKsOoZN5CBavO40f6isFpu3quM53CRSD+ccKKfmAlQ1
 MSQ9k7MqV0/M7JpCskUxj0yB1B9SQK1jNsjZLBW8EjfxRHShnTPH1Odd
X-Gm-Gg: AZuq6aLoxW21eKAZIMkSk+KSLzedxb6btEp/sj05T65nDk8yiNYvPUBA4bSFoEjpd+z
 Fdphjy993leXbkuQscRYAjLynYQva5huraxDgMLwVxW6JVBI2MFxfv7wOmlK00yW6PXLKqCOpCd
 MoObBaijHVT1hGlJ2ipB2cN932k6V0UJZ4cT0iRkeVYfDPgWueF1OlJ/KU5l/MNcgeyjUCYhTg7
 QTKPNWoCm2/BByJsOiyKSejch7FtVjUk3Aw04b+dEg6R91SKtS4n7LfgzeK0qyVevBZG6d9qAPQ
 jrLhA8xmDaKH42slYN4luZu1nww8Vb54FOJXSJz04CPFDgsb1BChPcFlqttjX2WcSzz3/r2QZf/
 C+EUk8dZQRXx04LBmyTQbJHzlOQvi994S5mGaA439q8vvf/Sb9/lCvHEM4NvCd/aMhRSR2JzBsQ
 GxLI/S0UBPz6h9AMhT6XthI5YOl2UymcCNmWQ=
X-Received: by 2002:a05:6a00:a20e:b0:824:9451:c1e1 with SMTP id
 d2e1a72fcca58-825275ee977mr3029570b3a.58.1771459147456; 
 Wed, 18 Feb 2026 15:59:07 -0800 (PST)
Received: from ehlo.thunderbird.net ([101.0.63.217])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-824c6b69f2asm17777396b3a.37.2026.02.18.15.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Feb 2026 15:59:07 -0800 (PST)
Date: Thu, 19 Feb 2026 05:29:02 +0530
From: Saleemkhan <saleemkhan083@gmail.com>
To: "Wu, David" <davidwu2@amd.com>, amd-gfx@lists.freedesktop.org,
 "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Christian.Koenig@amd.com,
 alexander.deucher@amd.com, leo.liu@amd.com
CC: Boyuan.Zhang@amd.com
Subject: Re: [PATCH 00/14] user queue support for VCN 4.0.5
User-Agent: Thunderbird for Android
In-Reply-To: <8f4d596c-1888-47b9-a922-d48bb1adfb71@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
 <4C922F99-7140-47A7-967E-D01DEF0D9ECD@gmail.com>
 <8f4d596c-1888-47b9-a922-d48bb1adfb71@amd.com>
Message-ID: <E4D35216-7325-4FBC-9270-27BC61BF2F49@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----K1EBRF8RQ8HAZ67WC048O1KL26W395
Content-Transfer-Encoding: 7bit
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

------K1EBRF8RQ8HAZ67WC048O1KL26W395
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pls share the firmwares I would like to try them with current patches=2E

Regards,
Saleem


On 18 February 2026 11:43:10 pm IST, "Wu, David" <davidwu2@amd=2Ecom> wrot=
e:
>On 2/18/2026 10:37 AM, Saleemkhan wrote:
>> Hi David, Leo,
>>=20
>>=20
>> Thank you for the UMSCH patches=2E
>>=20
>> Are the=C2=A0 UMSCH and=C2=A0 vcn firmware are upstreamed ?
>> I want to try this on Strix=2E
>>=20
>not yet - we are working on it for kernel first=2E A few patches here nee=
d to be reviewed/acked, then cherry-picking one patch which is in another b=
ranch as dependency=2E I have firmwares used for testing and branches for m=
esa and libdrm to support the kernel features, but not ready for upstreamin=
g=2E
>
>David
>>=20
>> Regards,
>>=20
>> Saleem
>>=20
>>=20
>>=20
>> On 11 February 2026 3:17:15 am IST, "David (Ming Qiang) Wu" <David=2EWu=
3@amd=2Ecom> wrote:
>>=20
>>     add user queue support for VCN 4=2E0=2E5 David (Ming Qiang) Wu (10)=
:
>>     amdgpu: add global aggregated doorbell bo drm/amdgpu: add
>>     AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL drm/amdgpu/userq: add
>>     doorbell size for VCN and VPE drm/amdgpu: use amdgpu_user_queue
>>     instead of amdgpu_umsch_mm amdgpu/umsch: Add VCN IP init to umsch
>>     driver drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to
>>     be common drm/amdgpu/userq: rework on
>>     amdgpu_userq_create_wptr_mapping drm/amdgpu/umsch: user queue
>>     support for vcn drm/amdgpu: add AMDGPU_INFO_DOORBELL
>>     drm/amdgpu/umsch: userq suspend and resume context Saleemkhan
>>     Jamadar (4): amdgpu/umsch: Update UMSCH interface and mqd
>>     structure drm/amdgpu/vcn: changes when kernel queue is disabled
>>     drm/amdgpu/vcn: handle interrupt received from fw drm/amdgpu/vcn:
>>     handle the suspend context interrupt
>>     drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh | 4 +-
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs=2Ec | 2 +-
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=2Ec | 2 +-
>>     =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec | 16 +
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_drv=2Ec | 10 -
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_gem=2Ec | 2 +
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_kms=2Ec | 18 ++
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Ec | 300
>>     +++++++++++++++++- drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Eh |
>>     43 ++- drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec | 69 +++-
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Eh | 4 +
>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=2Eh | 4 +
>>     drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec | 90 +-----
>>     drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0=2Ec | 75 ++++-
>>     drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5=2Ec | 122 +++++--
>>     =2E=2E=2E/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0=2Eh | 10 +
>>     =2E=2E=2E/drm/amd/include/umsch_mm_4_0_api_def=2Eh | 12 +-
>>     include/uapi/drm/amdgpu_drm=2Eh | 14 + 18 files changed, 646
>>     insertions(+), 151 deletions(-)
>>=20
>> --
>> Saleem

--
Saleem
------K1EBRF8RQ8HAZ67WC048O1KL26W395
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!doctype html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body><div dir=3D"auto">Pls share the firmwares I would like to try them=
 with current patches=2E<br><br>Regards,<br>Saleem<br></div><br><br><div cl=
ass=3D"gmail_quote"><div dir=3D"auto">On 18 February 2026 11:43:10 pm IST, =
"Wu, David" &lt;davidwu2@amd=2Ecom&gt; wrote:</div><blockquote class=3D"gma=
il_quote" style=3D"margin: 0pt 0pt 0pt 0=2E8ex; border-left: 1px solid rgb(=
204, 204, 204); padding-left: 1ex;">

    <div class=3D"moz-cite-prefix">On 2/18/2026 10:37 AM, Saleemkhan
      wrote:<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:4C922F99-7140-47A7-967E-D01DEF0D=
9ECD@gmail=2Ecom">
     =20
      <div dir=3D"auto">Hi David, Leo,<br>
        <br>
        <br>
        Thank you for the UMSCH patches=2E<br>
        <br>
        Are the&nbsp; UMSCH and&nbsp; vcn firmware are upstreamed ?<br>
        I want to try this on Strix=2E<br>
        <br>
      </div>
    </blockquote>
    not yet - we are working on it for kernel first=2E A few patches here
    need to be reviewed/acked, then cherry-picking one patch which is in
    another branch as dependency=2E I have firmwares used for testing and
    branches for mesa and libdrm to support the kernel features, but not
    ready for upstreaming=2E<br>
    <br>
    David&nbsp;
    <blockquote type=3D"cite" cite=3D"mid:4C922F99-7140-47A7-967E-D01DEF0D=
9ECD@gmail=2Ecom">
      <div dir=3D"auto"><br>
        Regards,<br>
        <br>
        Saleem<br>
        <br>
      </div>
      <br>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"auto">On 11 February 2026 3:17:15 am IST, "David (Ming
          Qiang) Wu" <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:Dav=
id=2EWu3@amd=2Ecom">&lt;David=2EWu3@amd=2Ecom&gt;</a> wrote:</div>
        <blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0=
=2E8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
          <pre class=3D"k9mail"><div dir=3D"auto">add user queue support f=
or VCN 4=2E0=2E5

David (Ming Qiang) Wu (10):
  amdgpu: add global aggregated doorbell bo
  drm/amdgpu: add AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL
  drm/amdgpu/userq: add doorbell size for VCN and VPE
  drm/amdgpu: use amdgpu_user_queue instead of amdgpu_umsch_mm
  amdgpu/umsch: Add VCN IP init to umsch driver
  drm/amdgpu/userq: change mes_userq_create_wptr_mapping() to be common
  drm/amdgpu/userq: rework on amdgpu_userq_create_wptr_mapping
  drm/amdgpu/umsch: user queue support for vcn
  drm/amdgpu: add AMDGPU_INFO_DOORBELL
  drm/amdgpu/umsch: userq suspend and resume context

Saleemkhan Jamadar (4):
  amdgpu/umsch: Update UMSCH interface and mqd structure
  drm/amdgpu/vcn: changes when kernel queue is disabled
  drm/amdgpu/vcn: handle interrupt received from fw
  drm/amdgpu/vcn: handle the suspend context interrupt

 drivers/gpu/drm/amd/amdgpu/amdgpu=2Eh           |   4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs=2Ec   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery=2Ec |   2 +-
 =2E=2E=2E/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr=2Ec  |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv=2Ec       |  10 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem=2Ec       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms=2Ec       |  18 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Ec  | 300 +++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm=2Eh  |  43 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Ec     |  69 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq=2Eh     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn=2Eh       |   4 +
 drivers/gpu/drm/amd/amdgpu/mes_userqueue=2Ec    |  90 +-----
 drivers/gpu/drm/amd/amdgpu/umsch_mm_v4_0=2Ec    |  75 ++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5=2Ec       | 122 +++++--
 =2E=2E=2E/amd/include/ivsrcid/vcn/irqsrcs_vcn_4_0=2Eh |  10 +
 =2E=2E=2E/drm/amd/include/umsch_mm_4_0_api_def=2Eh    |  12 +-
 include/uapi/drm/amdgpu_drm=2Eh                 |  14 +
 18 files changed, 646 insertions(+), 151 deletions(-)

</div></pre>
        </blockquote>
      </div>
      <div dir=3D"auto">--<br>
        Saleem</div>
    </blockquote>
    <br>
  </blockquote></div><div dir=3D"auto">--<br>Saleem</div></body>
</html>

------K1EBRF8RQ8HAZ67WC048O1KL26W395--
