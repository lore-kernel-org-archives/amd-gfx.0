Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C594CC369C4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 13:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5431A10E91C;
	Wed, 16 Apr 2025 13:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XWuoy2rF";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28DF410E8CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 11:25:33 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so68997345e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 04:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744802732; x=1745407532; darn=lists.freedesktop.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M1SJQCGEYPEhCrI3qgX6t+obEkrQ6EqASbeC+/fQb1k=;
 b=XWuoy2rF6Dbaq0acQ5kK8Mj13JSKXvRH0kkJAW4RrwVqXKh2HBvjhZT9cH24eUOxOf
 bnUNaN7LnaLEOGTQS4d6gODkY16j/KvafO7tZtc3NmALwAVH452QmXRRNNRYfIBTafG2
 qVKn7NYzoeuEd+T4O9zWMex+8Z7MCmmq+mh+5vKTFFEJocIk51YslkrxB9s+rvisE0Ju
 h4DH2WX6aoMskYIT+jtIvkbWjZs2eZTb3p9rtomo6qAY9hASZtKUXd1LSxT6nz5e5Kx8
 tNhZp7bOV293nohwtW3MjIwFWRmoYzDYmjG7SqOLyPz362YwucxJstUzP8PiJcdqtAhq
 I0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744802732; x=1745407532;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1SJQCGEYPEhCrI3qgX6t+obEkrQ6EqASbeC+/fQb1k=;
 b=JHLNwkD9ATrZfAENLl71sYZKodlPi7wTH5Lts/m4HJw+FraYXafjSxrWAX/Q9wFLyz
 B41m1eFAJCalx2viO+F3iAjHBMrFWqm5BYcMttGYgiPuImfd5yiG6oAheCOGgA517A/J
 0u2/SObK13fGYnkH1pGHFe4ZZxPLREuwCfq402wIetSOyMP9TfSaVQnxaOg9TLEHkl5Z
 VND0om76uhHJfgF0LOqjClfbX4JG6MZNbQg3JAbjmc48kTW5LxI/9SVnmFhwzKYA+SJ6
 NQaHxZ0agheSyTp8wWkRKm+5+hLDF0dptcjGOaWd75Mirp55HtgpuZUXlH3cDZy3zJVc
 XTag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn9/5L3+Iv4SyWaikyCTie/wo/ES/MsQeGkrD/zdqlgbuc73JHWFGyvbCYVbsCU/DxU4pl0I/N@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMiAWEFFmFUS7bkOWTO97Gm0uGBJQ4iQL9uEHO6ngIKl5eWsRJ
 MuMMwKyQ83mn2HuXCYh3dAEl2JIrCvX7Ad/7RQI6It+a+dbz4/2gqHenjCIMJTY=
X-Gm-Gg: ASbGncspcqL4WAOiApA7AVbbDwgsSOYC4lMY9TVdG030oFC7vliHfOM3WM6t4bhBmml
 vL+rB2iEbnKDpnUuOODyauei3dqvC9zYLFDkK1HFRRh+Bt/EatPEpsHsq+sBkll8tazcVLW+tSV
 MPVnsMQMd5Vb41sT44LF+AjmVtMGfvDtO7cxFsuT2N32nvgnVYmjLA1CSiDs/ZopuNk/EDcVwId
 mNNw0UmjekbgNxBbbFzPi0RDYs2Sds7vP+ezE/QqijgaYxc9E1Ty4V29SOcxGzD4Bv0YktBWyPl
 rxL3LjgtW7k6y3oWmMjJOAwGKNlRgV1VLOvzDOEB
X-Google-Smtp-Source: AGHT+IE2uGk7viULXRHwcMC6GtLWc6X+31aPOyWo4guoKeQ4IlVtxGCdVZQNStIgzEReOhLBuSGQSQ==
X-Received: by 2002:a05:600c:3d0c:b0:43d:b85:1831 with SMTP id
 5b1f17b1804b1-4405d5bd218mr15007975e9.0.1744802731815; 
 Wed, 16 Apr 2025 04:25:31 -0700 (PDT)
Received: from localhost ([2.216.7.124]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b5adb6fsm18524045e9.40.2025.04.16.04.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 04:25:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Apr 2025 12:25:30 +0100
Message-Id: <D980Y4WDV662.L4S7QAU72GN2@linaro.org>
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Fugang Duan" <fugang.duan@cixtech.com>, "alexander.deucher@amd.com"
 <alexander.deucher@amd.com>, "frank.min@amd.com" <frank.min@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "david.belanger@amd.com" <david.belanger@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>, "Peter Chen"
 <peter.chen@cixtech.com>, "cix-kernel-upstream"
 <cix-kernel-upstream@cixtech.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: =?utf-8?q?Re:_=E5=9B=9E=E5=A4=8D:_[REGRESSION]_amdgpu:_async_system_error?=
 =?utf-8?q?_exception_from_hdp=5Fv5=5F0=5Fflush=5Fhdp()?=
X-Mailer: aerc 0.20.0
References: <D97FB92117J2.PXTNFKCIRWAS@linaro.org>
 <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
In-Reply-To: <SI2PR06MB5041FB15F8DBB44916FB6430F1BD2@SI2PR06MB5041.apcprd06.prod.outlook.com>
X-Mailman-Approved-At: Wed, 16 Apr 2025 13:41:29 +0000
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

On Wed Apr 16, 2025 at 4:12 AM BST, Fugang Duan wrote:
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Alexey Klimov <alexey.klimov@linaro.org> =E5=
=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2025=E5=B9=B44=E6=9C=8816=E6=97=A5 2:28
>>#regzbot introduced: v6.12..v6.13

[..]

>>The only change related to hdp_v5_0_flush_hdp() was
>>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP
>>
>>Reverting that commit ^^ did help and resolved that problem. Before sendi=
ng
>>revert as-is I was interested to know if there supposed to be a proper fi=
x for
>>this or maybe someone is interested to debug this or have any suggestions=
.
>>
> Can you revert the change and try again https://gitlab.com/linux-kernel/l=
inux/-/commit/cf424020e040be35df05b682b546b255e74a420f

Please read my email in the first place.
Let me quote just in case:

>The only change related to hdp_v5_0_flush_hdp() was
>cf424020e040 drm/amdgpu/hdp5.0: do a posting read when flushing HDP

>Reverting that commit ^^ did help and resolved that problem.

Thanks,
Alexey

