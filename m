Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FC7C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 16:25:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69D52312E
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 16:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69D52312E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88FBF89458;
	Wed,  6 Jan 2021 16:25:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6BC36E221
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609948734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ySYSF2OyQCchabJjQg3PrccxtUT/f13/fpeIcznYp1k=;
 b=gKZBqd3aCEYNttHMfI/D+IQWVzecxGx/1Kblwnx456/CxrdYhm+2iv7mXtiIq+pK5rYdRy
 m6sU4KRmxqt3V//YohB5j9h/aZcaK6ST+1YkVa8q407ozUd/XFGvGYQna6eVzqjsxUSxHJ
 9uwTce1t1A351uG5NKglFuCmGkQ0SBU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-QyhIBhUpMPGjH7Hn2fSvfw-1; Wed, 06 Jan 2021 10:58:50 -0500
X-MC-Unique: QyhIBhUpMPGjH7Hn2fSvfw-1
Received: by mail-ej1-f71.google.com with SMTP id pv24so1453001ejb.19
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 07:58:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=ySYSF2OyQCchabJjQg3PrccxtUT/f13/fpeIcznYp1k=;
 b=p8kO7cKQnE0OopCeQYx+128xLvYbvC4IRlRpUVR1jr6ZWwLVZMlRE3bkw/VxMq4nhS
 9+LtPs2VA9b0A+TnvkOyumuXsRhJuI2c/E7pwCkLEFCOOAjGtwd/Gr42NVD1uiQf0DyL
 4n56lQzkZb8GU/0RDGflvE4fleKPnNJHYr7/SfpMPxvrokrHYLDjPGw80aDSWeQbtJcr
 i52UAfd9/1lbThIRB+pC56LCp/nYSUaV82eDO3mv6Me6hOYOOhWF0P8pnmA+qEuD2N9G
 cS0gvBfcLYjmc+YpuQCGMnSQWfII8HJlCIOA0UFCTorQ00jrICBAUCC1Vs6J4mUvLX2+
 GhMw==
X-Gm-Message-State: AOAM531y8LBiOTaMQUqTtlzur2XUvsZsU5k/K7on+8Lxvupg7hy+RedB
 5gSpIT1oU1gbkMZiAI/LSjC1tbXGvWLutNf5FK0hz3+tcSRJfKo18QGcC1QrXYNUvJuM8hfEZSv
 g+5o0ZJ1K0LthzGh53ODoPS8mAQ==
X-Received: by 2002:a17:906:3553:: with SMTP id
 s19mr3196588eja.95.1609948729310; 
 Wed, 06 Jan 2021 07:58:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJywZEFbzwyGI0sLjVlWUZiWbLQ7R9ONHSnrN0yn99ArwlJGy8SSvtCInioEqCUfkmwrdDeHIA==
X-Received: by 2002:a17:906:3553:: with SMTP id
 s19mr3196580eja.95.1609948729162; 
 Wed, 06 Jan 2021 07:58:49 -0800 (PST)
Received: from x1.localdomain
 (2001-1c00-0c1e-bf00-37a3-353b-be90-1238.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:37a3:353b:be90:1238])
 by smtp.gmail.com with ESMTPSA id h15sm1585900edz.95.2021.01.06.07.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jan 2021 07:58:48 -0800 (PST)
From: Hans de Goede <hdegoede@redhat.com>
Subject: radeon kernel driver not suppressing ACPI_VIDEO_NOTIFY_PROBE events
 when it should
To: amd-gfx@lists.freedesktop.org
Message-ID: <ed5b59f0-cfbf-57e8-2cdf-2d0e2c0c45bf@redhat.com>
Date: Wed, 6 Jan 2021 16:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Mailman-Approved-At: Wed, 06 Jan 2021 16:25:54 +0000
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
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi All,

I get Cc-ed on all Fedora kernel bugs and this one stood out to me:

https://bugzilla.redhat.com/show_bug.cgi?id=1911763

Since I've done a lot of work on the acpi-video code I thought I should
take a look. I've managed to help the user with a kernel-commandline
option which stops video.ko (the acpi-video kernel module) from emitting
key-press events for ACPI_VIDEO_NOTIFY_PROBE events.

This is on a Dell Vostro laptop with i915/radeon hybrid gfx.

I was thinking about adding a DMI quirk for this, but from the brief time
that I worked on nouveau (and specifically hybrid gfx setups) I know that
these events get fired on hybrid gfx setups when the discrete GPU is
powered down and something happens which requires the discrete GPUs drivers
attention, like an external monitor being plugged into a connector handled
by the dGPU (note that is not the case here).

So I took a quick look at the radeon code and the radeon_atif_handler()
function from drivers/gpu/drm/radeon/radeon_acpi.c. When successful that
returns NOTIFY_BAD which suppresses the key-press.

But in various cases it returns NOTIFY_DONE instead which does not
suppress the key-press event. So I think that the spurious key-press events
which the user is seeing should be avoided by this function returning
NOTIFY_BAD.

Specifically I'm wondering if we should not return
NOTIFY_BAD when count == 0?   I guess this can cause problems if there
are multiple GPUs, but we could check if the acpi-event is for the
pci-device the radeon driver is bound to. This would require changing the
acpi-notify code to also pass the acpi_device pointer as part of the
acpi_bus_event but that should not be a problem.

Anyways I'm hoping you all have some ideas. If necessary I can build
a Fedora test-kernel with some patches for the reporter to test.

Regards,

Hans

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
