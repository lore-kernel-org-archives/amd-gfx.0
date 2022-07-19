Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8B33C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 17:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D9F11A2BF;
	Tue, 19 Jul 2022 17:06:14 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EF8011A2BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 17:06:11 +0000 (UTC)
Received: by mail-qv1-xf2a.google.com with SMTP id t7so1359973qvz.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 10:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pIGT3yPvX69DwERnWyavBFcR2mldyfX5zPuK+8fcqO8=;
 b=XwlIfg7gruWwC48OEGG1CWr9Z8CT8odxCLNs5yfsz5pJLMUZeshjwOdQYyPlYH9Ept
 2cDFwuk/OpgCR3whLmkzcLymvgIe0BpMME56zo2g4WuHRzTN0/B+F06lOR+RnMbpJwVd
 4/nbPwy0VIuzyjcbFNHf+wncp65H74QVUNaaHqtxlXvVVW5/u/AarMLGPFuIBSERHWb2
 PNXmPhZMpusMoA5vBUjRGDc/eQXW4JbO5TZFbLk6mPkyzKqtLFnJ3tD7j0ChVn9bPJNd
 4lyseAcBtsTuFHqQGe1JfQnnLtZ3j5MnAnQ3+zkoeo9W2DUOlNU3lQnQq4cy7d1y07Vr
 EfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pIGT3yPvX69DwERnWyavBFcR2mldyfX5zPuK+8fcqO8=;
 b=Nt7BLNFMV/8io1yrGTNT0Yw0fBAtBJBY4msOD+bf1Y36SBL/YwqeiSavB3hWW2BPC2
 zlvI3Sl3aTUSShHFuSny8sG6iYLrAeHspIKwowV+B2nq1sfsCGYBOZ9aNfBwlauR78d4
 NcjDvKtdLvh/LsRAkja/GKmQ00Hd8So0PoQBNytT/oCseGuQBEZDPAXtcPpGhCMuASX5
 igBXNXKQ9iFMy6RMdEDOiKQsjlYey6sHeQ89hT+r9ei2HmT1hxvv5Vu1Hw2S43s5b4XG
 p3f87N1JlxdwcATyVPC5vrm8XLYjIZ69OHvZGGVV8FdaGlaAUUpddQnN0zwuW9LT7j58
 rFag==
X-Gm-Message-State: AJIora8YwP8VAldBGPISddX5SnoVfzDsGyh2a4+wntkcagKeT9mfKpVE
 N2Kt7+2s17NOAOZS2dgadx0m6y+SoqeVk2oMcqQ=
X-Google-Smtp-Source: AGRyM1vwQuZ2p+lZiV35/OA0pT3+b29U+PgBa9JUdUwPYI8qezRsk/+h3Bd4M9GQk4kCfTtNAtXCKQSYvDN3xNaAAHw=
X-Received: by 2002:ad4:5dc7:0:b0:473:e8d0:220d with SMTP id
 m7-20020ad45dc7000000b00473e8d0220dmr4194410qvh.128.1658250370460; Tue, 19
 Jul 2022 10:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
 <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
 <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
In-Reply-To: <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 19 Jul 2022 22:05:59 +0500
Message-ID: <CABXGCsOpPb9YAjTpeOzgWS+dPaQA2UKA-cT=HhVeCskod+-OAg@mail.gmail.com>
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

On Tue, Jul 19, 2022 at 4:26 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
> In the kernel log there is no error so it is most likely a user space issue , but I am not
> sure about it.

But I am confused by the message in the kernel log:
[ 1962.000909] amdgpu: HIQ MQD's queue_doorbell_id0 is not 0, Queue
preemption time out
[ 1962.000912] amdgpu: Failed to evict process queues
[ 1962.000918] amdgpu: Failed to quiesce KFD
[ 1966.010395] amdgpu: HIQ MQD's queue_doorbell_id0 is not 0, Queue
preemption time out
[ 1966.010406] amdgpu: Resetting wave fronts (cpsch) on dev 00000000b40e7982


-- 
Best Regards,
Mike Gavrilov.
