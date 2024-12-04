Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14ECE7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 14:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CC1910E0DB;
	Wed,  4 Dec 2024 14:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hkQ8yuoy";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A0A10E0DB
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 14:21:14 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2ee4f3ac479so671689a91.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Dec 2024 06:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733322074; x=1733926874; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oBkp2nhVNDih2XvCrhJF6VeYgAuhzI7D67uO5MDs/mM=;
 b=hkQ8yuoy5YO87XWqZ7t2GFZK+wI+71Ct65gfa6v/w4OAg6FQqnZkPvS5DPwS0Dx6I5
 Gn3+Ls+tmRbCcZ3IrCE69Z2Dl8ZiJbCd1l8O2U6dIfSlEa97s2eqLQac9iNg5scCfXkK
 XZH1SRA1VRhSP7t+GthBqQ68y/zCdc57tS2uE2SstF5JUupDSQogJzIgh981T6xMfGiF
 t5Pifyxt+17QRvU9C+EWlHv5OPtdRTNQlEItNH8hTl1g4syCY1yZ8/9mUyhNSyUwiZb6
 OfI47JIWO+GkdKoWQ0n/PCZrNTqg7SOIY0JkaLRC0b6wuuePKbmMpvBYqcMJt+xyNZEd
 xcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733322074; x=1733926874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBkp2nhVNDih2XvCrhJF6VeYgAuhzI7D67uO5MDs/mM=;
 b=lfQB0NhMSZh0CAnv4tDCd2yyTubHSo9wf20kJ0yvHq7vGBkdR8+EZbg2KMo2leSrc+
 tXXavddM4HrhgeIvgCIjxXxgqBZ7pPuG9sUW6VXZ30McZUqtxBsmxXdPoZv58x9yVxe0
 Of5vPHxiN2ihs8fpwpU5TKWBnV8GuiKBAWFhx7dPmxBnzx35xKQmoeHh/I7KIKN8YPfV
 XQGuq4r0B0uRmxc8iZhX2wO9KAP3t6Dbx6ALCB97By5ewI3/h/lXsB+UX0Ob5RQkvpUA
 60MkpWqkVMahV1kv+A7QXWTShmcBvefnRsFRwgrrPzM+nOewYWhpVxg5Q1TgZc6YOhSs
 4LuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAnEXtMmZ3k1LMItYK4efIm+KebMf/uQklq1Ts5kzV8+4EunIyAv+mksmrVsL8SCSNX5N/d57P@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyck2FfmnS+b/j3Bt+nci7ryNlLZZoq0sKYPY8s1t/oUuPsJeC8
 xQrMhLOMrg+apboGMVbXwVc9tNtiCc4ToZxgdjuERXVh6dGPXYMMN99jgOmWymGSiVl5n+93buO
 A74qZnyS9qCBSj5vcVmpnFBGNu64=
X-Gm-Gg: ASbGncv9F5QcDUMuyTufYfMYLQX7p4YCB3uLuLFeGwR54O4yxvQWhxzDrNvOxYJT/eJ
 /Jvuhf0LmHQv/FDa1uPpQKtE5q/y6UoQ=
X-Google-Smtp-Source: AGHT+IFrXVg2RBdLg7TQAQpf7Th16EDdvkp1jXsrxMSEIOggY+2aLkP5WM8SmacAURW/Xwsd647Ax/NXIURjHHDo5bM=
X-Received: by 2002:a17:90b:1b49:b0:2ea:5e0c:2844 with SMTP id
 98e67ed59e1d1-2ef0125b371mr3941790a91.5.1733322074375; Wed, 04 Dec 2024
 06:21:14 -0800 (PST)
MIME-Version: 1.0
References: <20241203181403.23515-1-mario.limonciello@amd.com>
 <e8ae8d63-44d5-4e77-818f-67cf69d0c8b7@amd.com>
 <c5a7f27c-c676-4e10-83ba-393a4df06ada@amd.com>
 <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
In-Reply-To: <20d00e76-7ce4-42d0-a968-d7adae616984@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Dec 2024 09:21:02 -0500
Message-ID: <CADnq5_MPEZA2CYfFnG3u--bDeD3eQyZO6igCQQqHEp-BJNwy-g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Wed, Dec 4, 2024 at 12:47=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 12/4/2024 10:44 AM, Mario Limonciello wrote:
> >
> >>> +enum amdgpu_ucode_required {
> >>> +    AMDGPU_UCODE_NOT_REQUIRED,
> >>> +    AMDGPU_UCODE_REQUIRED,
> >>
> >> Couldn't this be handled in another API instead of having to flag ever=
y
> >> load? By default, every ucode is required and if optional may be skipp=
ed
> >> with amdgpu_ucode_request_optional() API?
> >>
> >
> > I guess this would be a smaller patch, but 6 eggs one hand, half dozen
> > in the other?
> >
>
> I thought only ISP and gpu_info (no longer there for newer SOCs) fall
> into the optional ones so far. The usage is rare, similar to the
> nowarn() API usage.
>
> Also, as far as I know, the cap microcode is a must whenever used. That
> is not optional.
>

The cap firmware is definitely optional.  Some customers use it, some don't=
.

Alex


> Thanks,
> Lijo
>
> > Alex - what's your take?
>
