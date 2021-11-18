Return-Path: <SRS0=WI/b=QF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBBCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B387361A58
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Nov 2021 16:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B387361A58
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02EFA6E970;
	Thu, 18 Nov 2021 16:37:24 +0000 (UTC)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C427D6E970
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 16:37:22 +0000 (UTC)
Received: by mail-yb1-xb30.google.com with SMTP id d10so19799585ybe.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Nov 2021 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to;
 bh=0LJXkfRSk0bD9kdXnJO6wM6pY2IKq3raxCuWjzlxfBg=;
 b=JNYhDRaD0Mvl2557fz3HIJfR2gOs6hl58MKhitFSujILWZpZDZ10nP1tUDyopz4car
 MTnL5129kW32nEek2Vf+KXPTSDzMLt10HbEPLfoVTc1YSeOXlTwQ8oqZGxCpA6hURwud
 7JViYoI/nWznK+mjWJzO046iiIzxHPrmAfIiP6phG5yOI3BB9XwyGEQk8E7dRfF1M1Db
 Cr9pZCaOtdSpN3IRYWSShSVMgi0wi7P00h/rNsW3K5dTi7R2ePgZDQ3pygrapor0EULm
 z4sQweXeKj0+NwbX0iriiQb5WMdhjd7T9bd3Ijn7vSBgT4Y2+9SN0/E9S/T2/Q9Em7lR
 4msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=0LJXkfRSk0bD9kdXnJO6wM6pY2IKq3raxCuWjzlxfBg=;
 b=Rqk3N6eSsmdkoNn1V7XZ+/EEfP7odW6xWAzG0LL2PUnRbfzxRCDklTTAJtY8UoZx84
 iUmeZEW7i3eu3jr+PCdkUizlZq8v2oDYRv13YuC50HoxDGR/oQDoIS2kd6PTUhyfCHDJ
 0r0IYjpuymxegqxq8RNNiISn8LDgayhQOOo1QTOK9z7LP+hj1pgQOxnCgxoR246M5gkB
 4XV5xv8HBzO3eeiK8csJEjWQQGJOaP/3izYZW8Z+oErin7zAF5TmzIihSC0DiKeVJVL3
 moBQOQgPjAOQQz6IUn0REtEAJfrXB/WDGxIUfT+bF1LgwyV8fxS4JxmSGLa1reRmRTJM
 buLw==
X-Gm-Message-State: AOAM531LcKO96aA/lJYx3FwkOsIAgLAjLvOP9O7xhLyTNLTaPSwQ6Bmh
 FUR3WDeTDEgJUHXVMhB95C0KXBdavLSPxGNKwYxWVQZwrhg=
X-Google-Smtp-Source: ABdhPJxa1Gs5gB0fDeevt5Izr27u9/gsNnMYo88yqM87BSWYMEf86EQ+dkhQZweP+94gNS9DtdoUTRbbfvHqlYqJPjQ=
X-Received: by 2002:a25:a381:: with SMTP id e1mr28000672ybi.273.1637253441750; 
 Thu, 18 Nov 2021 08:37:21 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:1e0e:0:0:0:0 with HTTP; Thu, 18 Nov 2021 08:37:21
 -0800 (PST)
From: Amol <suratiamol@gmail.com>
Date: Thu, 18 Nov 2021 22:07:21 +0530
Message-ID: <CA+nuEB-4gWhk65vKx7hJdkXpk0mPxvuy_PkbA6a94nwZcseONg@mail.gmail.com>
Subject: [radeon] connector_info_from_object_table
To: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello,

The function radeon_get_atom_connector_info_from_object_table,
at location [1], ends up parsing ATOM_COMMON_TABLE_HEADER
as ATOM_COMMON_RECORD_HEADER if
enc_obj->asObjects[k].usRecordOffset is zero. It is found to be zero
in the BIOS found at [2].

Thankfully, the loop that follows exits immediately since ucRecordSize
is 0 because
(ATOM_COMMON_TABLE_HEADER.usStructureSize & 0xff00) is zero.
But, with suitable values in the usStructureSize, the loop can be made to
run and parse garbage.

A similar loop exists when parsing the conn objects.

-Amol

[1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/radeon/radeon_atombios.c#L652
[2] https://www.techpowerup.com/vgabios/211981/211981
