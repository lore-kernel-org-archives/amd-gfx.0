Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E9EC7115F
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jun 2025 13:02:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E606710E699;
	Tue, 17 Jun 2025 13:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="BdsvolV7";
	dkim-atps=neutral
X-Greylist: delayed 846 seconds by postgrey-1.36 at gabe;
 Tue, 17 Jun 2025 06:54:39 UTC
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61DA210E059
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jun 2025 06:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1750143267; x=1750748067; i=markus.elfring@web.de;
 bh=W/eYVUsYjhYNAzlFtlDPOabUz5P88wa8dv8eQF4JdOw=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=BdsvolV7bQyozsWc6AcsCzupRFadsD/7O5fmSEcENfpCfo40Bat/B6/UTB3DGRi5
 J3swKRGKjZ2vMQ8RRwSQ1obmvL5kEo4bFJ1b7BnvC34YOepN5vx+K0MeX2Ttq2SNm
 16QkZyiemjZyWns5sfH77P3b5gsJ1167pQnwUFr+lCyhT05SZ5A63xi0SfVm1dYch
 TwrbGvjx9qJmkcsUeIbaIw0ZZLF8kDMFbyDqcT7m8kNRfI1i+rR/sLHhBMJpisw7r
 YTE6Y9yGkoGRlWr+8HQkD1ed73iISc4SXfmQ9QmWLGpOitZrwoDcGQboZb4SMTOAH
 ANk2cjdu6dOKon3HNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.238]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRk0W-1uLStw45Uo-00L8b0; Tue, 17
 Jun 2025 08:40:31 +0200
Message-ID: <f9bffb72-b463-45d0-ac72-9a5ff4daec38@web.de>
Date: Tue, 17 Jun 2025 08:40:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] drm/amd/display: Fix exception handling in
 dm_validate_stream_and_context()
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 Roman Li <roman.li@amd.com>, Simona Vetter <simona@ffwll.ch>,
 Tom Chung <chiahsuan.chung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev, llvm@lists.linux.dev,
 cocci@inria.fr, Melissa Wen <mwen@igalia.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <e6656c83-ee7a-a253-2028-109138779c94@web.de>
 <ea0ff67b-3665-db82-9792-67a633ba07f5@web.de>
 <32674bac-92c2-8fc7-0977-6d2d81b3257f@amd.com>
 <da489521-7786-4716-8fb8-d79b3c08d93c@web.de>
 <8684e2ba-b644-44c8-adf7-9f1423a1251d@web.de>
 <ba89d859-f132-4e7d-ba29-47331e02152a@amd.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ba89d859-f132-4e7d-ba29-47331e02152a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hnrgU48qW8YbbumGxfVVaCQYutIW5tQhAnG2uxaNogCv+Volpoz
 NtmjNa9mVp1Vuc014Zos4Xx/7c7bXp3juCUjI3normNm47Rk1rswj21iMGDp7AcOX7DblMb
 KwwbP0mep3lNNqI9JxRT3dxZn3UYBMTSkeenIAn3Ux2HAwTpkF0J6NIhXnlxWYwlkXIwnis
 mJXovzuulJoDRcs3vcBIQ==
UI-OutboundReport: notjunk:1;M01:P0:7HxqG3Rx4i8=;wS1c0XkyRDcJGb/QEhbXkR61HhH
 tkRwZP1B8wc0tVzdgDSftWkbEwOeKPMw2XfjVej0vzTWFYxh/iuqlD5lAhThEd1Ckf8CMzMl8
 4OJt22BSVoCiIvVrOcLbsmHpJIGfgAEIVyGqf5z2VMKUHDSYKFjiiJPNRM2Y3zXtesCfCXIqc
 EG349bvAI/EQppY9GR0n5yVn9e79SUR21zBrfga53PWeKMCnoZSEbKLWqOvJnLXTfNtisIj7D
 VN1sRj0idZwGj98BkAYZtKBe7uhPwbVI5Bk601Qdc6l5XhEno4eFjAkv4v9a1iqzCa/kpWute
 0Yjgm6N7tCnXoca2kRmVP/kc6GdtR0qqsnEj9jBQgBf7g6RNVPP0n+KnB49JTdEOrNVk56aUR
 XXXYSZeuD0QBOyU8IB9rFKFhk34tJ0cmrjjwZYcJfDWqo8XI2Ac3pSgQ1sfUBdKwlP2UAnH3E
 YDoSxB4allM/o4dpApgb76gAjkUWtsCjaTd1C1JtB1EPfIUDgtaD5/VkLJSyoRMB3HmCF4JU4
 +goepjk9LxBzCArTDNFz3n1TYiti3bm9TfFLP9hYtq0ZFlVlesD0GO/dLTD6DQwvKirL/U8pT
 hFwbKArAbuIU3DYO/DScdbeJEIay8uqjNeHBrnPQvO0cygMxCouSm1RgMBTmfE3EYuCAGAkys
 77dBJ0ozA8+l1J7Rysj/LS0kaZzRiXu6hbWKz+8e/MS3iv9J8bJTnEGU9h5QTkBiardH1xf7A
 AJ4SDFGL9KjJvghmYnCC6EdSrCcwcvXu6S1oqSDR4DdxvuI25jf2F3nnTGqcFlpM+CaI6iByu
 A5H/NEJtIXjwf18ts71QXypTBZZn3pcuitlCnRe8CcrL3wKN++ON/OJ4utqqEvtf1DY+YT7m0
 M2CPbQXW+2IPX2IfutsKY83yG3cRtY6+TLJt3ssITR0x/rg3vv2NO50mLwaqcZkK6GI31v+JN
 twv5cf5TwNXb5o8j0tv8qnQKck+UdTn8yHH1XkT8gPLmLHsytkE/k4euKRC8qPWT5xxp+vfsd
 3XReQxQ06GIAE+L2OKQ7na1jTEkwlyVm+MSrMRGBhQBwibUpJhXW/oRB+vtl7VmJizRKzsdSy
 GD7gaC4ea61+0Z2xzcsyr+TKxb2OI9wM+Qd5Z1iFfLh33qOl8/3aAp+wHCxxodW4i+qdLiPPD
 f5ozJlSjmGWAXQ+RggabtN+fH5tPf1IGY5ooA0NMqndoikOiiVcqHbHy94wpEcZ5//DuVReKU
 Trvdg7P/sA23m13WVFf0Hx9qU6hLLTScuUvRFzZQ2CIA634bT7GpfYCwHtg9FyhdFP37tL+yA
 j9UUiwFKyz/3G88Dh2FPgl6+ylnitXArUNhh7xv3qCOY1udK0oSY4cQDuOJeXZaP2ZfIJzy3t
 kwCQrnIIGhOH1bStHcAQa1rS0NlLxIVVtpu6IVJPZYWNQh2k2fe5T4ISclfAfTP/TDe4J+BI5
 +u2kFpnvgt45sjOaWsax2gh2pZwqQOlnlGEH7LlN6dbWlneZF14rnAUzjRbv1EvNPmfQftYtw
 tZaluim3/Y8ThC7Sg/G97+Xzj7n0m0zhmyvsFvWZpYTfTtUGVS12iWJiosEDQxTY4D32ypAsZ
 liOFhzSNhvJnk5llFaA0trHihp59UFSPP7yfw2TUF3cvvKj9J3NzNz1TAWaXTcWBy0J+eZ/ll
 QO4QwfLB5MGUDAaUvGt7JY+NpyVbkUS3KcEqegIkaxwE2Q5WJIE1Dr0mW0cYSi6I+SzDQqlu7
 fIn5nq+/rFXS3+81RkZHtZfyjSwuWeUP5RzBJUt9yX6Q5Ldyl5h1isfZ93Sw4YkqPDFZMtiyX
 foddLXj/1qCifZxOjAbcf0GQ47BwWBJT9z6ko3DZ8xWr2vOxV8n25nbF0VDR8hojxy4KxW879
 DKTAVn31zHSLKiWVOBiPTqV3E2BUlEzXfqjE8YSN8979NKoJnOPY+Zrsnof6M+wP6217KkGJI
 5PCPKQx6VqfqT/Q1NPw39m26iXN79/BnlyAm+lMm6AajJzKAxeclLlVkQg82qvL9Yun0/NNpt
 0OI/mhm3ryhxJwFX35/qpe6XkhaMAzgwqXI+D/9nr3A94zx152fiDSXm6E5ik7SnqYceX3Wjx
 9e7TelwcQ3aArCrdkpPDfqG+M/pv6WfyCI2CCcXyfxU7KdDC5xio8mGwiKEP67BiiT3uWkzR/
 a9fMbxg7qLNR7OJT8dF95ixEagz+oVqmmFEF41GnHkqHQ4ud7vqCNoQydq9V4SUn/CulrWEg4
 7LLqZO/hSFJ2W9t94IWi1UnduVf4wNnbI+u1NtV1zm3OK2RVsBMZhlLqLG4tUtSnUnr5AZM/X
 rAmFjwEzXmpyQz1k6/wZNnrfkXPn39vVEFbyqW/8IUuiCKtdYsd0CiPd+7Qm4/iISwakgGFa9
 Mpgx1X4wM2yCtMgMMSBHbKXPxh21h4k0Ku6Ijn3/ykHydMlyGIRSh9RUO9F/MFJj4t/5Aq4/L
 Tr5n0eg7vnO+xWQjU5DO8GCdZHE1YpsEzLxctlYQ1s/5yku6UINaKp0J1NzDNG9L+bcuDXsFn
 k+YN2tHVHoKM0uAxEXJH96fgLFWZUeXmuwpzc3NXTcWDMwTZ3/mbO+1S/gp5fJLxTZkA38YMx
 gAeraPgjuTQ6GiEoK5ULdHblzOLedfQIeKf/jqhJJBoHlitGFmIq2WTNTxnsVYfaRwY18N/2W
 znchKwBo1LL3XhYcK2BRPoQvKVpctQW6M5ie3b8+WeixAd80y8+34PNROyo2+x8IzUhQ/QuBA
 o80yqmYmCT4Gu9L8vPrn3DkIyx1o1Rnuvjuq8k672Fi3OrtpYTFrTbjLPYv9+Wf3mCndp+mYN
 kM0e3GsmL5CpGnagTgg/QKyqpbt2ARMAlymljgdeTDv410LdIAZ3dNMIBXY5M3idokVwT6ssg
 xgGb4YGOr3fWG9VfXpo8gRAT/9uRFog3LzFI0q6NPxKaOStf+r/ysloHPTpO5nXH3We7Ts9kR
 m+g9igow42sBoJBnLfLMe+s42cJ5S5f/P7uibIDGOcyigoxL4jkrUl5JfpsYKBOM6DJR0iTJN
 5g6mDV+12Qw+36uh+zgKlZRfXmbUpbx+Tm6GPP52QnI+upMUCwqJH+/n7WQQfdN9jXvZFlBRg
 JCXDeEbpO/b8YGPPzJgs0wlOBTLyYmV1SN0z3kxZ0kDQjrHW57A5qH/ohN2PvfVMwaxbjbJio
 YJf2se7Idrk1cE1oha4PaXkqOf1szO7fGt1juoKN7s6MqeSfp3HcEkDEPaZxKNST2iRLhZ/oI
 hp6wI9UXaNAT9mu8GKqYltgLf1TikEDXCOnG4A==
X-Mailman-Approved-At: Tue, 17 Jun 2025 13:02:39 +0000
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

=E2=80=A6
>> 1. Thus return directly if
=E2=80=A6
> I guess the intention was to reduce goto statements.
=E2=80=A6

Partly, yes.

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.16-rc2#n532

Regards,
Markus
