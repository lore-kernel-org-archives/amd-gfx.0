Return-Path: <SRS0=dIjB=7B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B3FC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 18:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A4820758
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2020 18:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzhBZqaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A4820758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 318196E453;
	Tue, 19 May 2020 18:45:44 +0000 (UTC)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690D06E453
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 18:45:43 +0000 (UTC)
Received: by mail-oi1-x236.google.com with SMTP id l6so642047oic.9
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2020 11:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=k3FC/20Mj5OPsflmNW3rWXC8fBeDPR0+/vOg2n8J8Kg=;
 b=QzhBZqaSo132xKC2AQ68oK2mvwNUvQUb4ChovKPJXaA/f+Zxzexv1Btab8WnHmyFu0
 EuXYmg8QHDnHsp4skYsjYWKHrBh+PrQ2KJitoxQMOH8a8t9UAtSgnrwdDKUwp2nuYbeb
 Ge+qEZvi/S2CrmWocKgLEN+7yxA7Qj+T8zHxS5wUe1W5kvVaxaq5JntsKRGdRyWHTeEL
 cqUpnCC/nJArGfdBqxLW4G9Pd6+3FtNqXdBU+DKxCPN8YjoCQMLZXhc49VqqV/LWcHh+
 a1FIZoTHn35XzlOldbBIihtCzKJfTQs2XVAe9X/y13MsgdlxJQaNMqorBH8sUM1i6r24
 TRdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=k3FC/20Mj5OPsflmNW3rWXC8fBeDPR0+/vOg2n8J8Kg=;
 b=IgKnVgyomxjrta0wjbQ+4aHqHUg+/qsZlPT5PsVv0NCyHsqWl47K+liiNxBJcWuFUh
 vtZD5k3jNRgoP0YBTelficLmfzy69sLHi4oCsfDqT0+z/49M/SWGxoVkX/I4UmSgVS6G
 WUGE2n2jZu/2m1tGwDwcSJlemjq4G3nPUJjKrOA3kYG96tgVEwiATSDENUZnw52I8E6x
 +x3d550QOFfBsKzJhQJRuAwI7Xg1FsHRiXlRvcRCSNpFBs12dXE9vUkiA8nLFhgcYSQS
 4c+UZBJWGYBvNCuT6jJNoxANsuvy00XO0bg82P7uNzRX23oJecJJ7PyJcenKzsRbxIzh
 E5eA==
X-Gm-Message-State: AOAM530Hner3rT/WaIWxiONM5MASrEe5VdhNjSBhGi73uWmUvbIgk3Ju
 9+cKedYCpU/93tZmnQOnOv1vtLZzbPWJyuMuXyRzbAthKas=
X-Google-Smtp-Source: ABdhPJy+SSSnrTZGQd2VWclE6SeSzO+4ERYukWrkll2UOsg7Y0b5/dN3pYQd59o/AvxVqxcXYtyiyiIOsCt5ARziTMw=
X-Received: by 2002:a54:418f:: with SMTP id 15mr593423oiy.109.1589913942331;
 Tue, 19 May 2020 11:45:42 -0700 (PDT)
MIME-Version: 1.0
From: Javad Karabi <karabijavad@gmail.com>
Date: Tue, 19 May 2020 13:45:31 -0500
Message-ID: <CAEOHGO=uKYs0YQyG5K2BGd=_83j_m6nfompstAF-znRfus69Hw@mail.gmail.com>
Subject: regarding vcn
To: amd-gfx@lists.freedesktop.org
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

for a rx 5600 xt graphics card, is VCN supposed to be set to disabled?

if i understand correctly, 5600 is navi10, which has vcn

but i currently see VCN: disabled

$ sudo grep VCN /sys/kernel/debug/dri/1/amdgpu_pm_info
VCN: Disabled
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
