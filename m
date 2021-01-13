Return-Path: <SRS0=tf5m=GQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A552C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 13:51:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D48E23339
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jan 2021 13:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D48E23339
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4352F6E9DB;
	Wed, 13 Jan 2021 13:51:42 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 138D66E29D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 09:05:43 +0000 (UTC)
Received: by mail-yb1-xb33.google.com with SMTP id r63so1497857ybf.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jan 2021 01:05:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=z4yscdUtnULssD517mPJjeUd6WoWX4L14ZsynTjehpE=;
 b=gQiVjvfdEnlpPrip4XFGYfnfhL0KJn51/01qEAIqjTGZc70poNi+CRUjJPvM7nKrZz
 QrjGWlB9KBoayjdqhB82y6MHFvpXBPRRRxMlkhoVeyHDlcm7msl4+/E7jp5dovvTd0lE
 kdQWw2hdRVCtYvgvZkC1Yiqd2IZh3f0jfgaV+xfUexmrnMzUECHzRUkUkgOpKpxkULhL
 twuOJawkJEqEBPcy7aHAiRVCkzE/gOhjwfbsQPfoXOJTMTwkBufbPqdZBNm68tRIRJd+
 LJlb9l4yU0uXF4eJmlCXpAPH/8FEBkNfX8S7NYgF7Q9ZmUr5WuJqRvgeEo3xGKdWV87k
 Yqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=z4yscdUtnULssD517mPJjeUd6WoWX4L14ZsynTjehpE=;
 b=AfCJOK6VB81Ab1q7MSK+7p0ps/8K/9QfYBmH/azkCaHDUtdkcps1M6Necf0FnFgNEv
 +0u14Xr6KhsSaENHKz6Dut82Q4ze5uhRaQ8DE244Utm93dGksehv//4B2XpCTUQ3kMXJ
 j48Vl3yEubufPfJA6lLy7TxKWAohQJLI7zQEWLq5LLnVIHfd5DDTgbzp2lwaTWMamz+I
 Y79i9iU6Lhj4/l6wavQk9TF5tlmbP0RXHSSE355D8S9+4P01ytzEbozzwwb5Fy+YeOg9
 JSveVNUlXDVPvfAf2FR5IhmFHuBwij0D+1P+bbUrM3PyCQ5UwI9tiUmowlQ0ahiZeHA/
 nFXQ==
X-Gm-Message-State: AOAM532z0tO0u2WG25/B6WuYxYFy6BA3W5Ibb4ldZSaJSlmUCDxQM68/
 Btsdln7U3YWoXsLj8VZALUWRGKN26mDVjhEdC9BTEGJSTRo=
X-Google-Smtp-Source: ABdhPJzz9ehIIAkaS0O0SN1vnbzmbyWsyv9HVlqwG2IjdQ3O6qaIrTsUjssBMp2zyVqohFo3jYvLEaLtCQhRlpVR2nQ=
X-Received: by 2002:a25:bf82:: with SMTP id l2mr1874100ybk.1.1610528743093;
 Wed, 13 Jan 2021 01:05:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7110:7a1:b029:30:3664:8494 with HTTP; Wed, 13 Jan 2021
 01:05:42 -0800 (PST)
In-Reply-To: <CAKR_QV+SN2Q962_v0WpeCL9tRBUBQpZ+EO6FvF8ZQ-8DG8UwMg@mail.gmail.com>
References: <CAKR_QV+SN2Q962_v0WpeCL9tRBUBQpZ+EO6FvF8ZQ-8DG8UwMg@mail.gmail.com>
From: Tom Psyborg <pozega.tomislav@gmail.com>
Date: Wed, 13 Jan 2021 10:05:42 +0100
Message-ID: <CAKR_QVJ6NRXZhrJEph=HxPe2O_DYwzhE3Hj52BKkX2PGEMoyAw@mail.gmail.com>
Subject: Re: mclk stuck at low state
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 13 Jan 2021 13:51:41 +0000
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
Cc: "alexander.deucher" <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

I see the message didn't make it to the mailing list? Any reason for that?

On 10/01/2021, Tom Psyborg <pozega.tomislav@gmail.com> wrote:
> Hi
>
> Have an ubuntu 16.04 system here with kernel version 5.6.14, running
> on a laptop with FX9830P APU.
> During graphic load I notice the memory clock is always at the low
> state - 667MHz, never switching to 1200MHz. These two states are the
> only ones listed in pp_dpm_mclk output.
> I checked system memory with dmidecode, it is reported as 2400MHz.
> Same bug is still present with live booted ubuntu 20.10
>
> Does this introduce any regression in performance, or is just a
> cosmetic bug and actual mclk is the same as system memory clock?
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
