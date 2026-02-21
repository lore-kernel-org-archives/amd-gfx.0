Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91F5E98E06
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Feb 2026 08:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24C8510E27B;
	Mon, 23 Feb 2026 08:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y69RQlh+";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F4B10E855
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 01:39:21 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-385bc6910eeso25346931fa.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 17:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771637960; x=1772242760; darn=lists.freedesktop.org;
 h=in-reply-to:references:mime-version:content-transfer-encoding:from
 :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
 :reply-to; bh=VxhPVUyoO3hiTWkFoFkhmqlDhO5q4VD+zDs9agEE6iI=;
 b=Y69RQlh+tvkaCQ7IigtHgjdBYMJCNp9K4II8BncJo7LeQWQl6ZthX3dIGlw4v63CgP
 BHGZw5c0vLxIQscrfSpLwzjjOlxDe1OlQm3EoPf/tuyfQBKYPMAP/P09vm0cF7ynTPtU
 ennFuC/FRg+S8KPybEQNjD2nCyA9ShmyiaSSeqWjP5bkOOyNSyLUhwAkL4/lWMUbnV8u
 cmBDgp0UmBPW3QUV/neV/Wowti/RQSFkkOGC4doOy+rGtf7AF8ZXdUUtyhhM/c3NhCFp
 1TVguOfSxOuM45e/BWbjT4SR0GLYbqOjSiDyGuNq+4BZdqmF230wLfVMuYGvU/ILMiSE
 56XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771637960; x=1772242760;
 h=in-reply-to:references:mime-version:content-transfer-encoding:from
 :subject:cc:to:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxhPVUyoO3hiTWkFoFkhmqlDhO5q4VD+zDs9agEE6iI=;
 b=eMK/j6xxzXG/fhlVAFEnFQIoFCFulLNfoNSPB0VcBttDsJyA1A3CdWYOUx+O/xttCJ
 TIHO72v6Oyrn5vsG57/I9aruZCqbi2ccNN5RCFYdUwn8552Oh8UgyNIsbcXY5IJWb12f
 BYFruUooPpn+Vr3yuh0YJtMyHuw6x09aF7wIqm1l+zLKdOCn7FeRjXOwgaZiRkenu+L1
 nF8Yxv/3cIvEox3ZzTOu/V3/fCn6uirY9QqJ0uk5vvZ7cUXADFarnWUsUZK6I/reN2bb
 tZ415UXgLjB4o/+TIOxYWEj1pX5ysfK9vscVdxSKG2l+DoNR/cu8KONgBP7iKxs6sU2A
 qFYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Dben8MG3ZewgjU+jo044/oPHZP70hmjlE1+6PnyQNNQCoDYuY4D2tzMp+eafyWi02irWIPf5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzbp8H7hvmYX16ty7VMi+dK8fgyVctaoVzQ19B5beWCbj8vx2Rg
 v60yXneX2Yvny1a2llBQbNSlQpm+goojBky9ENKigJrJGrceWpWfNn0=
X-Gm-Gg: AZuq6aLIrfXSMTN00RYXYUhLjwy26mM0vlONz3/CV+y2MwoggcvmmsInaxXEL1eScBW
 YWwz5nmEYrAu7oaW6M87Th6Z7k+goz1N17L9bW+e16z4tH+gKp4gq8ms1qhbgyCk0wENztArvOQ
 RHH9a2ILJZeIs5KAiMttP3z3HJkShrgC4ntzw41y6zpP2g6xT/iUXtI4VLHCjgtgkMzugNOkNp9
 7neOe4perYI4Y93PGZtStDf2+WAafcbeQ1DnyPIS/b8VBTSRAewU+tnWEget5/k5BY4URjbpY3o
 jKVnwQt638s9depTYAQEWBDvN/qHvKyoVa5reZYbLha/L7Wp6ri7I8aPj934UhL8GMONfh3TDiC
 F1YcjiJafnKTILkuizEHSmdmQPJTQB21Af1iq/1IDpgOX9B0HgD+Saert27djn+D8iUYqz9BVaB
 mBhEwP4CHl
X-Received: by 2002:a05:651c:31dc:b0:386:8f97:d0b4 with SMTP id
 38308e7fff4ca-389a5e4cf70mr5274401fa.33.1771637959898; 
 Fri, 20 Feb 2026 17:39:19 -0800 (PST)
Received: from localhost ([2a0e:e6c0:20d0:4f00::1d])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-389a78d2326sm1752321fa.15.2026.02.20.17.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Feb 2026 17:39:19 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 21 Feb 2026 04:39:18 +0300
Message-Id: <DGK98QFUDRR2.1RCLDXI8XRBFR@gmail.com>
To: "Melissa Wen" <mwen@igalia.com>, "Ivan Sergeev"
 <ivan8215145640@gmail.com>, "Mario Limonciello" <superm1@kernel.org>,
 <amd-gfx@lists.freedesktop.org>
Cc: <dri-devel@lists.freedesktop.org>, <regressions@lists.linux.dev>,
 <mario.limonciello@amd.com>, <alex.hung@amd.com>, <daniel.wheeler@amd.com>,
 <rodrigo.siqueira@amd.com>, <alexander.deucher@amd.com>,
 <harry.wentland@amd.com>, <sunpeng.li@amd.com>, <christian.koenig@amd.com>,
 <huangalex409@gmail.com>
Subject: Re: [REGRESSION] VRR not detected on a DisplayPort monitor using an
 AMD GPU
From: "Ivan Sergeev" <ivan8215145640@gmail.com>
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
X-Mailer: aerc 0.21.0
References: <CAKx_Wg7_HBxuq5W4T_AmoFYJGQpa6TAS_Fx9SUzyy1itPmj5Bw@mail.gmail.com>
 <090d89a2-4f80-44ef-827c-6462d8948493@kernel.org>
 <DGJFVPAQJA15.378GMU7XZXLU@gmail.com> <DGJGDIRQWDG7.XHHKF6UQP0HG@gmail.com>
 <c70fe261-7fb0-4af5-b755-f02b193c8c5f@kernel.org>
 <DGJH30US2XMK.S2HOHR14LIW0@gmail.com>
 <bed447c7-07a3-46a8-9bcf-da352810883b@igalia.com>
In-Reply-To: <bed447c7-07a3-46a8-9bcf-da352810883b@igalia.com>
X-Mailman-Approved-At: Mon, 23 Feb 2026 08:29:05 +0000
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

On Sat Feb 21, 2026 at 1:47 AM MSK, Melissa Wen wrote:
> Can you check if the attached patch resolves the issue?

The patch does resolve the issue!

There was a problem with my particular setup caused by the fact that my
greeter didn't have the VRR feature enabled, which made the desktop
environment take longer to start and the following error messages were
printed to the kernel log:

amdgpu 0000:2d:00.0: amdgpu: SMU: I'm not done with your previous command: =
SMN_C2PMSG_66:0x00000028 SMN_C2PMSG_82:0x00000000
amdgpu 0000:2d:00.0: amdgpu: Failed to enable gfxoff!
amdgpu 0000:2d:00.0: amdgpu: SMU: I'm not done with your previous command: =
SMN_C2PMSG_66:0x00000028 SMN_C2PMSG_82:0x00000000
amdgpu 0000:2d:00.0: amdgpu: Failed to set workload mask 0x00000001
amdgpu 0000:2d:00.0: amdgpu: (-62) failed to disable fullscreen 3D power pr=
ofile mode

These errors do not appear without the patch, nor do they appear with
the patch if the greeter and the DE have VRR enabled (in my case, GDM
and GNOME Shell respectively). I have not tested the case of greeter
having VRR enabled, but disabled in DE.
