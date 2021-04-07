Return-Path: <SRS0=AiXT=JE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23CAC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535B06124B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Apr 2021 02:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535B06124B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5927F6E13A;
	Wed,  7 Apr 2021 02:37:10 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83FB46E075
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Apr 2021 01:19:04 +0000 (UTC)
Received: by mail-il1-x12f.google.com with SMTP id t14so14822542ilu.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Apr 2021 18:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=RzqCAnTmgFQvfhZMwnzIFN9amo0uChyMoc0Zk82DM1g=;
 b=kIafOMkrWtqklCMDy2DD8e6zLLCb6ROcOm1Hwpd2ySWESOZf5/jvzBX2DPh8AB61UB
 QCQSO1umrbrRVZvAnG+T1ivZqTrAOZ3plqZHkTk8e0Ka7dML8If3J7WxTqwI758winr+
 OFSEvxWEo0oAr6tm2cxrCKta4+Icqqt30Bl11Bv3vGpuD3QiXBZ0YlzDm8XyoFA5j3xT
 RAwlPinbjtZPggW+gIVj9YQ3fuPLkdlElMIwjLmShwWOUZKn92nSZ7l/airFlONDks7U
 YCYJlClCxiD2BiFon3pXgVM4TrkuH5GJSNB6U+PmG26x8xnPglL+RRnhbnrnEfZwjgh+
 7jNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=RzqCAnTmgFQvfhZMwnzIFN9amo0uChyMoc0Zk82DM1g=;
 b=dm1z+9LSW8bQKmvvYjfZHy4gaBf82C2cWigkEKiB6KNWfw4mFBYOmQ7hPxCk6ibuwZ
 ijis0VPVnOjJ7F1SgWJJRbqoLzG9iM8H9ArcakUq/mdhijSexARrTeKtDKndfxj2HDoF
 SBbfTMV18LErERC91AZrIUVmC3BrfZ9C2WtbS/nBk87pUuqrDkWggmMWL/C/ka4uM9RT
 SYv4W7ck7oqVLRk7CeFanGMSzto3+W1JTWgskF05Py43nT1xk0l7+syts55LP7jv0m59
 J7JMauFF0zDVap0yOZSogJzMYLa6pQwHDWZAOpUcaQ1JKZwWWhJjbJ6iK8xGNV50bmFN
 PUWA==
X-Gm-Message-State: AOAM5325VjN+SJ/wbQDDNBAQB3YhzDKJJx7WkbN0jYyUoACnVP3SNsuU
 PqZwSI9YIApQU+JGNDM41013nKJtf8Exkg3FsLEFh94zXPA=
X-Google-Smtp-Source: ABdhPJzlqMdEUx0TOpXxiCPm5ZMTBvx8Otu+VFkRQ5nQKaCWiwaC7wIQ/6CxT1BDs+hrAwJum9Pa2BbClMU69behZmk=
X-Received: by 2002:a05:6e02:17c6:: with SMTP id
 z6mr859621ilu.256.1617758343662; 
 Tue, 06 Apr 2021 18:19:03 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?2LXYp9mE2K0g2KfZhNmF2LPYudmI2K/Zig==?=
 <almswdysalh404@gmail.com>
Date: Wed, 7 Apr 2021 04:18:21 +0300
Message-ID: <CA+jaEHVmLbkUKTEs1p-kYAdzAVb+KQOmdrKtCqABudLGsSTfyw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: add DMUB outbox event IRQ source
 define/complete/debug flag
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Wed, 07 Apr 2021 02:37:09 +0000
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
Content-Type: multipart/mixed; boundary="===============1002374524=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1002374524==
Content-Type: multipart/alternative; boundary="00000000000068115905bf57b788"

--00000000000068115905bf57b788
Content-Type: text/plain; charset="UTF-8"

771763840

--00000000000068115905bf57b788
Content-Type: text/html; charset="UTF-8"

<div dir="auto"><br><br><div data-smartmail="gmail_signature">771763840</div></div>

--00000000000068115905bf57b788--

--===============1002374524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1002374524==--
