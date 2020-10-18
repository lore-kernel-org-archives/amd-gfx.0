Return-Path: <SRS0=J5eG=D2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E74C43467
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:38:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74BE021D81
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2020 12:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CE3TTm0Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74BE021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB83B6E94D;
	Mon, 19 Oct 2020 12:38:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FA06E0F0
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2020 14:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603029898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
 b=CE3TTm0ZWS3xUbYzjwLA7+TYTk7Dg+VxIL4Zp73oDsqTuzAXXNjBX0Doq5M5Cu6ffXkYev
 bZ3C9BpL47kMqRFuXYSmeuVfmCYD0R8cyybmNyMbwair6n3qDaCsRQ2KiiaxG8Fe9Zs8sm
 6xUrramWNvo4ZIP3aUKUh3vEKSsfIgI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-7g3BOuQJPUe-ua-M5DoIyw-1; Sun, 18 Oct 2020 10:04:56 -0400
X-MC-Unique: 7g3BOuQJPUe-ua-M5DoIyw-1
Received: by mail-qk1-f198.google.com with SMTP id y8so5481609qki.12
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=kBVMPnQfqrYuRmZ0mFLSkNqYWCaxPfshC6ZYuKW12NQ=;
 b=BMse67r7w2irdF393K/uqYyBdkX7FhNi/hKSVRkzwVifi2vsq54cshbZ85vHsJC9ph
 2hh8TqMina1+/kAUGqEcirNexmYCR5+3bH0CFnnTL01eI6YovT9YMuJQSFySK256vkEC
 +iK/mizD60ghE2lERrKsr3z2hkefixWTbktQHsS3xeSv7RV4LV6diLqMyGKwpkGquoJL
 i0fNTGg24F/dz4qHPz69cdRGc4r8+NF6TiCvqAChCijDmnWo/Yo8E6B52cU8fyAXjneN
 6n6YsjmAP9LPTIgrx2ovGKyccJymj4x7CCCLq3fzfQIM192w5rOl5ynUhtuXrR+uXONb
 JMkQ==
X-Gm-Message-State: AOAM531SEuYAz4zrR3fzwgf2BczxQ0EdIUPF+KPXk4Li3WNfmeEBJlV7
 R1OM+pRVK4y/yIwgXArm6ZxbNWjuWzooj71ebWanwNffT+bcUG5B4yyUX3zzjoWunDuz/0ILEC9
 EMdD7W8haJ1KeKRqI8MHKVEQOWg==
X-Received: by 2002:a05:620a:1287:: with SMTP id
 w7mr12724324qki.436.1603029896366; 
 Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6z5rS79nBj0nCbIqVRZ9qmkAzjArqewdITB0rtwnhi1UUe/kvxLZTENMJDRITA4iBlrUAlw==
X-Received: by 2002:a05:620a:1287:: with SMTP id
 w7mr12724258qki.436.1603029896034; 
 Sun, 18 Oct 2020 07:04:56 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id u16sm3288927qth.42.2020.10.18.07.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 07:04:55 -0700 (PDT)
Subject: Re: [RFC] treewide: cleanup unreachable breaks
To: Greg KH <gregkh@linuxfoundation.org>
References: <20201017160928.12698-1-trix@redhat.com>
 <20201018054332.GB593954@kroah.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <eecb7c3e-88b2-ec2f-0235-280da51ae69c@redhat.com>
Date: Sun, 18 Oct 2020 07:04:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201018054332.GB593954@kroah.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Mon, 19 Oct 2020 12:38:47 +0000
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
Cc: alsa-devel@alsa-project.org, clang-built-linux@googlegroups.com,
 linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
 storagedev@microchip.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, ath10k@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, usb-storage@lists.one-eyed-alien.net,
 linux-watchdog@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvdimm@lists.01.org, amd-gfx@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 industrypack-devel@lists.sourceforge.net, linux-pci@vger.kernel.org,
 spice-devel@lists.freedesktop.org, MPT-FusionLinux.pdl@broadcom.com,
 linux-media@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-nfc@lists.01.org, linux-pm@vger.kernel.org, linux-can@vger.kernel.org,
 linux-block@vger.kernel.org, linux-gpio@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-amlogic@lists.infradead.org,
 openipmi-developer@lists.sourceforge.net, platform-driver-x86@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-edac@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-crypto@vger.kernel.org,
 patches@opensource.cirrus.com, bpf@vger.kernel.org, ocfs2-devel@oss.oracle.com,
 linux-power@fi.rohmeurope.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 10/17/20 10:43 PM, Greg KH wrote:
> On Sat, Oct 17, 2020 at 09:09:28AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> This is a upcoming change to clean up a new warning treewide.
>> I am wondering if the change could be one mega patch (see below) or
>> normal patch per file about 100 patches or somewhere half way by collecting
>> early acks.
> Please break it up into one-patch-per-subsystem, like normal, and get it
> merged that way.

OK.

Thanks,

Tom

>
> Sending us a patch, without even a diffstat to review, isn't going to
> get you very far...
>
> thanks,
>
> greg k-h
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
