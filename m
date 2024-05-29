Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2971CC25B75
	for <amd-gfx@archiver.kernel.org>; Wed, 29 May 2024 13:48:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5271B10E3B8;
	Wed, 29 May 2024 13:48:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i7TwuUrz";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6F6610E3B8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 13:48:31 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-1f32b1b5429so14819915ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 May 2024 06:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716990511; x=1717595311; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0z/FpElCuh+Q54pb9tJb+le28Rv+BIQInFTTqUBe2ik=;
 b=i7TwuUrzv8YwhdYjdERJahOUN3LMoXRnOYwpBawlZBxhd1oSgKfH1uo6Vyuj/fvVn2
 OJCtZwgzV8rR7vmDlHyjTQSWZok4ow0sB4eJ5EhUczGr95PrUxGVb/yqMdZ/sxteQcYN
 k54ZwoCdsNym+3PJPRM4WSZnWSTzGKCdWS0rQb7tCozirkrIWegmVXa0bMD/EA/TWEEi
 QdCSVqXvZa6mFA7AUlqdkKf7Oh2Kh0kGy7k76tajkgi8SJApWFsVexjIh01o5Cnk8iQt
 F7x/UNtZbJd1u8B026aqUZN766Dn3LPoOEfYQFC7V2QhYSAEu5NuY5F16YTYoGgHmp9W
 CjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990511; x=1717595311;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0z/FpElCuh+Q54pb9tJb+le28Rv+BIQInFTTqUBe2ik=;
 b=qb66NspdQvQRnAPGDFROVFYJmAOuK0lvuexAEM4euXwmVAatACM+RwcAA4QxOzI1R9
 rhBK6Rzz9hhPLZLcktpLduyP5sYPweLI9AtYPNHUVLuXSc7xZLoJMX4oZRLeyQQPE9Vo
 Fora6Dlvwj1hHnJFvUxAIW7OEAAyoTWzGDPlikaFlrktoxbBCYNGYcx0lLdUOEmOpSqu
 n7qUGhaQLVYSv5pjA6FEYruf3m8CruyMX9qvz71kie7jKp4eIGGKAkz7v191kuUpiqlh
 7vYvn80FdlsrBsCS+iKUcyF0gJgcv3rREDVmDbzCB6u/agCYNl6cvmdtVT7M2kCekpNd
 LyfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuLR+xpEeKavKrFWQ8uCJIqg6mCmhZiDbRlvKfqjMVOzXR87lY7fsWpz+RZfH8FPjKR6U3dlTzSwc1eytwdq9oz7OXSRsrhaQ61EL6NA==
X-Gm-Message-State: AOJu0YwKMcNI08Xl9BUS0uW/QnFGI2u0vu1h0fo1zdFIrLoVNGU+WdQ3
 O+mACiA0iaIYUtYZowSN0yLJXyBHiQ0O2p555EkDO5To5rU31SCd4gpfK8pcgQfYu7QE7T2iC50
 In/fH6reYV1wg2re8v/u5Yjb7lpI=
X-Google-Smtp-Source: AGHT+IGLKUznnYYWWDV06WcF6TOjaJQv5eWQQOjE5AVcetokb4fKLEn/u2jUWVEAojwcTI0uytvmOiZpQ3FYi02buHA=
X-Received: by 2002:a17:902:e5d0:b0:1f4:9474:e44d with SMTP id
 d9443c01a7336-1f4947509b0mr125629805ad.21.1716990510732; Wed, 29 May 2024
 06:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <ebb3b35e631169041e70eb0a7efd6cecef609833.camel@sjtu.edu.cn>
 <6ad1e363-5f22-46ac-b9de-9e4e87a59e9c@amd.com>
In-Reply-To: <6ad1e363-5f22-46ac-b9de-9e4e87a59e9c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 May 2024 09:48:19 -0400
Message-ID: <CADnq5_MT-h2AfG1VxTXAOU+FTdDYogO9xt=udYw11fuTawY3Uw@mail.gmail.com>
Subject: Re: [bug report] drm/amdgpu: amdgpu crash on playing videos,
 linux 6.10-rc
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Wang Yunchen <mac-wang@sjtu.edu.cn>, amd-gfx@lists.freedesktop.org,
 Xinhui.Pan@amd.com, alexander.deucher@amd.com, Felix.Kuehling@amd.com, 
 "Liu, Leo" <Leo.Liu@amd.com>
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

DId you also update mesa?  There could be a UMD change that causes the
page faults.

Alex

On Wed, May 29, 2024 at 3:37=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi,
>
> when the issue is easy to reproduce I suggest to bisect the changes
> between 6.9 and 6.10-rc1.
>
> On the other hand it's not unlikely that we have a known bug in -rc1
> which will be fixed by -rc2.
>
> Anyway added Leo to the mail thread since he is the one responsible for
> the video decoding engines.
>
> Regards,
> Christian.
>
> Am 29.05.24 um 06:05 schrieb Wang Yunchen:
> > Hello,
> >
> > After upgrading to Linux 6.10-rc1 (Mesa is left untouched) I identified=
 a strange bug that could cause the GPU to
> > crash and reset while playing videos online with VA-API. The screen wou=
ld first start to jitter, then flicker once or
> > twice, but the desktop session couldn't be brought back. After a reboot=
 I find the following messages in system logs:
> >
> > 10:13:05 kernel: gmc_v11_0_process_interrupt: 52 callbacks suppressed
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be8000 from client 18
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:05 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be8000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b01000 from client 18
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:06 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:10 kernel: gmc_v11_0_process_interrupt: 222971 callbacks suppress=
ed
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:10 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be8000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b01000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b01000 from client 18
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:11 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:15 kernel: gmc_v11_0_process_interrupt: 236783 callbacks suppress=
ed
> > 10:13:15 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00103A11
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: unknown (0x1d)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x1
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x1
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be8000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b05000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b01000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b00000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103be6000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: [mmhub] page fault (src_i=
d:0 ring:8 vmid:1 pasid:32777)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:  in process RDD Process p=
id 2857 thread firefox:cs0 pid 2909)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:   in page starting at add=
ress 0x0000800103b01000 from client 18
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: MMVM_L2_PROTECTION_FAULT_=
STATUS:0x00000000
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          Faulty UTCL2 cli=
ent ID: VMC (0x0)
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MORE_FAULTS: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          WALKER_ERROR: 0x=
0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          PERMISSION_FAULT=
S: 0x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          MAPPING_ERROR: 0=
x0
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu:          RW: 0x0
> > 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring vcn_un=
ified_0 timeout, signaled seq=3D5197, emitted
> > seq=3D5200
> > 10:13:16 kernel: [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process inf=
ormation: process RDD Process pid 2857 thread
> > firefox:cs0 pid 2909
> > 10:13:16 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset begin!
> > 10:13:16 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reac=
h value 0x00000001 !=3D 0x00000002n
> > 10:13:17 kernel: [drm] Register(0) [regUVD_RB_RPTR] failed to reach val=
ue 0x00000340 !=3D 0x000002c0n
> > 10:13:17 kernel: [drm] Register(0) [regUVD_POWER_STATUS] failed to reac=
h value 0x00000001 !=3D 0x00000002n
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: MODE2 reset
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset succeeded, tryi=
ng to resume
> > 10:13:17 kernel: [drm] PCIE GART of 512M enabled (table at 0x000000801F=
D00000).
> > 10:13:17 kernel: [drm] VRAM is lost due to GPU reset!
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resuming...
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: SMU is resumed successful=
ly!
> > 10:13:17 kernel: [drm] DMUB hardware initialized: version=3D0x08003A00
> > 10:13:17 kernel: [drm] kiq ring mec 3 pipe 1 q 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: [drm:jpeg_v4_0_hw_init [amdgpu]] =
JPEG decode initialized successfully.
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM in=
v eng 0 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM i=
nv eng 1 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.0 uses VM i=
nv eng 4 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM i=
nv eng 6 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses VM i=
nv eng 7 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM i=
nv eng 8 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VM i=
nv eng 9 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses VM i=
nv eng 10 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM i=
nv eng 11 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv en=
g 12 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring vcn_unified_0 uses V=
M inv eng 0 on hub 8
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv=
 eng 1 on hub 8
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: ring mes_kiq_3.1.0 uses V=
M inv eng 13 on hub 0
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shad=
ow start
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: recover vram bo from shad=
ow done
> > 10:13:17 kernel: amdgpu 0000:03:00.0: amdgpu: GPU reset(1) succeeded!
> > 10:13:17 kernel: [drm:amdgpu_cs_ioctl [amdgpu]] *ERROR* Failed to initi=
alize parser -125!
> >
> > A crash of the program playing video (Firefox) is then triggered. It co=
uld happen any moment while playing videos. The
> > problem is not observed in Linux 6.9, it appeared only after upgrading =
to 6.10-rc1.
> >
> > I'm new to amdgpu and I've peeked into source codes but couldn't find a=
 call chain for the error reporting code. I've
> > also went through drm-next commit logs, and from my understanding the u=
pdates introduced to 6.10 are many and I
> > couldn't bisect them all. However, I'm happy to provide you with a kdum=
p or a process dump if you request so. Please
> > also allow me to know how I can provide you with more information.
> >
> > My system information: Ryzen 7840 HS, 512MB dedicated VRAM configured, =
Mesa 24.0.8, kernel 6.10-rc1.
> >
> > Hoping to hear from you soon.
> >
>
