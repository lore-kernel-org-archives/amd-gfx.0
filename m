Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3E1C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 11:26:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C0011A03F;
	Tue, 19 Jul 2022 11:26:23 +0000 (UTC)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD85812A42C
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 11:26:20 +0000 (UTC)
Received: by mail-qk1-x734.google.com with SMTP id m7so731008qkk.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Zj2vSwWLjHhdOghbkFyO2x020jbfnFjdb1H8pyvZ0As=;
 b=kEHeD8Jooc4pSo0l4igOizCdoICj/kVQfN533zGFK13r0+qe2E+aT8IhcwKP1gqOU6
 eLBpxTlVClzXs81a4n/YYbvu3jhV8zIOlW98B3D9PdpOtW/UgnTmf9c113f69lvHi4e4
 5CfQP4HXnTIq/JX3VMiQIT1AHQh4YDAeIQnDg4Fgk5tJzKqXKoXaJfD8teIM8veEqMcw
 Rlvclbp8y3valaTMFJzXDJTbi5d6sfDly9wLxddlXY6rB3dXn8aToq//vJcO5YBVAsTv
 KaLmfIyK3rSOWJUMJJNqXDHa6rehVwM+HY1wZ3AhSmU6tmnUA2tevqtOm9ILKTDxEGr6
 Apow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Zj2vSwWLjHhdOghbkFyO2x020jbfnFjdb1H8pyvZ0As=;
 b=p30HK+Q0t7DXzf7uEs9YqKb90VmahO1Zv+JP6A85bY7bKRbKa0M9B/XsSUNjjFvtdI
 EUlrnCSOUf1DAVluqRx/dHQrwia5yBrqK6g40qqTph3YfoiclRVWA7dgd8HHdyikkLXE
 74NsXF1q1UugKJdbC15gkPRti4yBASVnzQbQYNb0ATJt1mhBgnIUB5y+WpwkEm3x4dlF
 LJx60TcJKb2Kocx+uLg6joLk22L02yA26r3Wlvd7cko+J6YwgzAqz8QRYaxGlACJOhvX
 C0uRBpfLF8Qqvwnmc8t/9dIepSW5SHUsGoVsMUnx2/QdH3dmmpsvl6s5RC6Cl2fBIAIT
 2QtQ==
X-Gm-Message-State: AJIora8J30x9hszD6M3/BvTZ8F9JfmwDT253RGWchn2aYY9VXeEPI81v
 G0heR/RpS3+xGI4mcFJLNEOv6LPCj606Rkz29eYbNk0NJil3nxFxDkc=
X-Google-Smtp-Source: AGRyM1vnEAZbtXcRbBKdb0v90eSYy+6qITpc1hAy6u9D25CBQU4p6BZweUCVK4xB+S88cr1OkyCGlKT5qwtcSFW3fhI=
X-Received: by 2002:a37:946:0:b0:6b5:c58a:6ab1 with SMTP id
 67-20020a370946000000b006b5c58a6ab1mr15045126qkj.663.1658229979845; Tue, 19
 Jul 2022 04:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
 <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
In-Reply-To: <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 Jul 2022 16:26:09 +0500
Message-ID: <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
Subject: Re: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
To: Mike Lothian <mike@fireburn.co.uk>
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
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 19, 2022 at 1:40 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> I was told that this patch replaces the patch you mentioned
> https://patchwork.freedesktop.org/series/106078/ and it the one
> that'll hopefully land in Linus's tree
>

Great, I confirm that both patches solve the issue.
As I understand the second patch [1] is more right and it should be
land merged 5.19 soon, right?

And since we are talking about clinfo, there is a question.
No one has encountered the problem that on configurations with two
GPUs, it hangs in a cycle since it completely occupies one processor
core. In my case, one GPU is in the RENOIR processor, and the other is
a discrete AMD Radeon 6800M. In the BIOS there is no ability to turn
off the integrated GPU in the processor, so there is no way to check
this configuration with each GPU separately. In the kernel log there
is no error so it is most likely a user space issue , but I am not
sure about it.

clinfo backtrace is here [2]

[1] https://patchwork.freedesktop.org/series/106078/
[2] https://pastebin.com/wv5iGibi

-- 
Best Regards,
Mike Gavrilov.
