Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE14C369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Apr 2025 08:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6712310E52C;
	Tue, 22 Apr 2025 08:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ksFzO2o2";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3253210E4DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Apr 2025 02:21:03 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2483236f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 19:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745288461; x=1745893261; darn=lists.freedesktop.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4af7Xc1+5cnfHb5k0WJTCxDvRo5jrtAyH2B4OstKv4o=;
 b=ksFzO2o2wGjO3C0c60ks/DWMnQiEu7XFy4WePekT6HI+6pz45T8jefn4cY7b0UGmO3
 k7gl66X4idLYNsAm7xxwYxBuaQ9WnmZC5SMBIoUAx7nOS5LdalWMWxB8Vy8/6MbwkBil
 erDyXlyH6ayxniteKREGTMCfPMPRMfMWWGiH/Rk5g930s7saQuHwSqaSRUYCQaP6P+eC
 tqYrOBMplaELzPxOQ1+BjpYwOhgE065U5UPMxtCIXKo2sFWO56ffIrvJBzKk7DahDQ6I
 7/nrhqM+aHiE9x8I5dQk7O/eCqNhqGLW/BOUKs3KegPVpZZ2j4zehzQ6gu3PMY6JvEBt
 9w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745288461; x=1745893261;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4af7Xc1+5cnfHb5k0WJTCxDvRo5jrtAyH2B4OstKv4o=;
 b=wFdJ8s2KMfagBymde9g0CFCMR7dT19WIpNKnoOSrfUdCBtz0K8R+KnyxZCoR83fLpp
 KilTekNFHtWpqizQFEi3mIs3Nj0e6WCOTZIuVdScA4ccPsVae/nBjFY98Wt0Ydj9YLQH
 aimrjIZINHhrdGRKG1gVh2uOHLDCDDUT3LaOrii5pyr/QKEMcGANjzcvnT5fcQDuUwhr
 FOvk3SgMsHu1lMnX7Mq8SDO/uZiEFpQHye/iRfcDw86yCS4ZmMJ8C5K5PuPvEYV0FmcW
 TFto46WkPsrQddNNUfv132FxtvEUigTsjGotxWNuMNVYyVTVn5g9JSY+5aaTlagL/kiQ
 rZtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh0rofSCMF3xB1SyFQeJjItUJAlnWPD2Rih79IixOeqBh8Mo4benO/X8hm4UjQpRCP8oTTr1eL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxq7F3JTO8zAq34bQYL7d2N5GNjR79hbxJ6P1prQPadlrxJJyH/
 TIADANdGnRqKBMUvd7rZs+jyWCy/aVIx1yLpMFW6IA4Jd96JEvXDZ5EgY9Rz2rI=
X-Gm-Gg: ASbGnctRPnYV7EnQpx7QwQP4E9fA3JmeQu+XIa+xt6PyA0qBPBcdQZPJMTUCqVxOUrF
 YrVvFShsYFMHaWWeyAmo6nxU/uDJ+bdLHJHnD3oLyMT5jiMXpzXJWpudw/tZKSV97mczrT00B7o
 yxOnEnu777PToNfGVUgCmS4Pbwr4GeNNLG40PIBvlcL+qA8b1TdpobpoLYFpWiEwExcTPFmC9ef
 V3tQIlh/WoCFjWYv4N92wwT7/SPPN3yFnzupYcdUNy7WNAupB/5vymBKV9G1e0SVGZjsFiN39Lz
 pqzihsOBoCVZPH0T43FF5v6CDLu8Zlcxwbsq+RtE
X-Google-Smtp-Source: AGHT+IFgeV/8j5th33piQmdTquaU2Z4bEmnQQNcAV7T3TABQNERWr1QfIiL6vJSAQOiHKjbGoM4Bwg==
X-Received: by 2002:a5d:47cf:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-39efba2ab65mr12333940f8f.10.1745288461621; 
 Mon, 21 Apr 2025 19:21:01 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa4a4e9esm13748087f8f.96.2025.04.21.19.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Apr 2025 19:21:01 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 22 Apr 2025 03:20:59 +0100
Message-Id: <D9CT4HS7F067.J0GJHAGHI9G9@linaro.org>
To: "Alex Deucher" <alexdeucher@gmail.com>, "Fugang Duan"
 <fugang.duan@cixtech.com>
Cc: "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "frank.min@amd.com" <frank.min@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "david.belanger@amd.com"
 <david.belanger@amd.com>, "christian.koenig@amd.com"
 <christian.koenig@amd.com>, "Peter Chen" <peter.chen@cixtech.com>,
 "cix-kernel-upstream" <cix-kernel-upstream@cixtech.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?=
 =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
 <CADnq5_NT0syV8wB=MZZRDONsTNSYwNXhGhNg9LOFmn=MJP7d9Q@mail.gmail.com>
 <SI2PR06MB504138A5BEA1E1B3772E8527F1BC2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
In-Reply-To: <CADnq5_M=YiMVvMpGaFhn2T3jRWGY2FrsUwCVPG6HupmTzZCYug@mail.gmail.com>
X-Mailman-Approved-At: Tue, 22 Apr 2025 08:15:48 +0000
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

On Thu Apr 17, 2025 at 2:08 PM BST, Alex Deucher wrote:
> On Wed, Apr 16, 2025 at 8:43=E2=80=AFPM Fugang Duan <fugang.duan@cixtech.=
com> wrote:
>>
>> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alex Deucher <alexdeucher@gmail.com> =E5=8F=
=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 22:49
>> >=E6=94=B6=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org>
>> >On Wed, Apr 16, 2025 at 9:48=E2=80=AFAM Alexey Klimov <alexey.klimov@li=
naro.org> wrote:
>> >>
>> >> On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
>> >> > =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.or=
g> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816
>> >=E6=97=A5 2:28
>> >> >>#regzbot introduced: v6.12..v6.13
>> >>
>> >> [..]
>> >>
>> >> >>The only change related to hdp_v5_0_flush_hdp() was
>> >> >>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>> >> >>
>> >> >>Reverting that commit ^^ did help and resolved that problem. Before
>> >> >>sending revert as-is I was interested to know if there supposed to
>> >> >>be a proper fix for this or maybe someone is interested to debug th=
is or
>> >have any suggestions.
>> >> >>
>> >> > Can you revert the change and try again
>> >> > https://gitlab.com/linux-kernel/linux/-/commit/cf424020e040be35df05=
b
>> >> > 682b546b255e74a420f
>> >>
>> >> Please read my email in the first place.
>> >> Let me quote just in case:
>> >>
>> >> >The only change related to hdp_v5_0_flush_hdp() was
>> >> >cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>> >>
>> >> >Reverting that commit ^^ did help and resolved that problem.
>> >
>> >We can't really revert the change as that will lead to coherency proble=
ms.  What
>> >is the page size on your system?  Does the attached patch fix it?
>> >
>> >Alex
>> >
>> 4K page size.  We can try the fix if we got the environment.
>
> OK.  that patch won't change anything then.  Can you try this patch inste=
ad?

Config I am using is basically defconfig wrt memory parameters, yeah, i use=
 4k.

So I tested that patch, thank you, and some other different configurations =
--
nothing helped. Exactly the same behaviour with the same backtrace.

So it seems that it is firmware problem after all?

Thanks,
Alexey
