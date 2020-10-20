Return-Path: <SRS0=LN+i=D3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C769C4363A
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 18:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5D13206CA
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2020 18:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dqj1hqYp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D13206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4F3D6ECF4;
	Tue, 20 Oct 2020 18:00:37 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1336F6ECBE
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 13:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603202165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HyQ28xr5/lapv6azTtFCvHFT5XQ1+OzeHk+84iEm66Y=;
 b=dqj1hqYpU6/y2h8V+kIQptv0xhdOCg30nYjG0UuQPR4HzPGpwcXs8bTMbLhH/MZ4iyaOGe
 bIsQLktd/HxsejJ6iD6T7AP53V0El8WD9AX/eQ5RKofX+tIH76o2/BtELPXTXNDVWD5wEg
 LuY4RW3ZSsnbV2leAXQmqfUp5Xe8+Ec=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-QgHklqG5Pwiz5cpjQZEylw-1; Tue, 20 Oct 2020 09:56:01 -0400
X-MC-Unique: QgHklqG5Pwiz5cpjQZEylw-1
Received: by mail-qk1-f198.google.com with SMTP id b7so1789256qkh.20
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2020 06:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=HyQ28xr5/lapv6azTtFCvHFT5XQ1+OzeHk+84iEm66Y=;
 b=qEy5j3fvPRpnmHsxPQqf17ZqCtUNvuarHdfBvwjJbp4BNkLMgN5dUWXiEGt6GUfAQX
 rBYnPEgBvq7TbACVYPjKwRWjh+s5n2ywm5FvJ+fxivlo/hFQqA9PECVlMr6XAV+YHm6p
 QYJ+UmbsUzmj5BoHax5FT/V7NgJeL+UPgRMGPbtXZMNQeC5BGtyQ9WnZas1PNls93R41
 qbZvLEgw3qzxJBAMUCzOfbJzkHIghYpZAb4W8PM8F1diHak78YFTffUrY5NPpZHV0YJO
 9M3U+YvsP+nWR5uNC4omjgXqz4TVfod5wJttUQa9CFieonJjGJ7r3/04WuDldifxP8ij
 YciA==
X-Gm-Message-State: AOAM532GJ8BqH4X6s3DTrOKjdvSz3I07tZGOC4uTN+DirHo486St0wal
 WImT/v/13BuacCqd90skFTmGCI5/wMV3O1ZTtXgCJcVLgZZV8/hINboGz6hj3nfpgNIpvHnMRao
 00pY0VUwGlkaxs8UvboGxx+b0Rw==
X-Received: by 2002:a05:6214:174f:: with SMTP id
 dc15mr3370440qvb.25.1603202160688; 
 Tue, 20 Oct 2020 06:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLUAfqrAOJzxwKF3+voCBF5yQYNbMOvfOkDZhumkJj3bEnT15V4x8vUJ5iQ5pWt9KusIZtsQ==
X-Received: by 2002:a05:6214:174f:: with SMTP id
 dc15mr3370377qvb.25.1603202160139; 
 Tue, 20 Oct 2020 06:56:00 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id b8sm775938qkn.133.2020.10.20.06.55.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 06:55:59 -0700 (PDT)
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Nick Desaulniers <ndesaulniers@google.com>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
 <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <ca1f50d6-1005-8e3d-8d5c-98c82a704338@redhat.com>
Date: Tue, 20 Oct 2020 06:55:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdkR_Ttfo7_JKUiZFVqr=Uh=4b05KCPCSuzwk=zaWtA2_Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Tue, 20 Oct 2020 18:00:36 +0000
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
Cc: alsa-devel@alsa-project.org,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Greg KH <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 nouveau@lists.freedesktop.org, storagedev@microchip.com,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, ath10k@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net,
 linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvdimm <linux-nvdimm@lists.01.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, linux-acpi@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, industrypack-devel@lists.sourceforge.net,
 linux-pci@vger.kernel.org, spice-devel@lists.freedesktop.org,
 MPT-FusionLinux.pdl@broadcom.com, linux-media@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-nfc@lists.01.org, linux-pm@vger.kernel.org,
 linux-can@vger.kernel.org, linux-block@vger.kernel.org,
 linux-gpio@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-amlogic@lists.infradead.org, openipmi-developer@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-integrity@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-edac@vger.kernel.org,
 George Burgess <gbiv@google.com>, Network Development <netdev@vger.kernel.org>,
 linux-usb@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-security-module@vger.kernel.org,
 "open list:HARDWARE RANDOM NUMBER GENERATOR CORE"
 <linux-crypto@vger.kernel.org>, patches@opensource.cirrus.com,
 Joe Perches <joe@perches.com>, bpf <bpf@vger.kernel.org>,
 ocfs2-devel@oss.oracle.com, linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/19/20 12:42 PM, Nick Desaulniers wrote:
> On Sat, Oct 17, 2020 at 10:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
>>> From: Tom Rix <trix@redhat.com>
>>>
>>> This is a upcoming change to clean up a new warning treewide.
>>> I am wondering if the change could be one mega patch (see below) or
>>> normal patch per file about 100 patches or somewhere half way by collecting
>>> early acks.
>> Please break it up into one-patch-per-subsystem, like normal, and get it
>> merged that way.
>>
>> Sending us a patch, without even a diffstat to review, isn't going to
>> get you very far...
> Tom,
> If you're able to automate this cleanup, I suggest checking in a
> script that can be run on a directory.  Then for each subsystem you
> can say in your commit "I ran scripts/fix_whatever.py on this subdir."
>  Then others can help you drive the tree wide cleanup.  Then we can
> enable -Wunreachable-code-break either by default, or W=2 right now
> might be a good idea.

I should have waited for Joe Perches's fixer addition to checkpatch :)

The easy fixes I did only cover about 1/2 of the problems.

Remaining are mostly nested switches, which from a complexity standpoint is bad.

>
> Ah, George (gbiv@, cc'ed), did an analysis recently of
> `-Wunreachable-code-loop-increment`, `-Wunreachable-code-break`, and
> `-Wunreachable-code-return` for Android userspace.  From the review:
> ```
> Spoilers: of these, it seems useful to turn on
> -Wunreachable-code-loop-increment and -Wunreachable-code-return by
> default for Android

In my simple add-a-cflag bot, i see there are about 250

issues for -Wunreachable-code-return.

I'll see about doing this one next.

> ...
> While these conventions about always having break arguably became
> obsolete when we enabled -Wfallthrough, my sample turned up zero
> potential bugs caught by this warning, and we'd need to put a lot of
> effort into getting a clean tree. So this warning doesn't seem to be
> worth it.
> ```
> Looks like there's an order of magnitude of `-Wunreachable-code-break`
> than the other two.
>
> We probably should add all 3 to W=2 builds (wrapped in cc-option).
> I've filed https://github.com/ClangBuiltLinux/linux/issues/1180 to
> follow up on.

Yes, i think think these should be added.

Tom

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
