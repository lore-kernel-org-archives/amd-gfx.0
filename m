Return-Path: <SRS0=+gD6=E7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA03C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:55:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D8B20679
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2020 13:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8OkXRKg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D8B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E1586E9AF;
	Wed, 25 Nov 2020 13:55:27 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B3D46E9AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 13:55:25 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id a65so2244011wme.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 05:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9P/IcxoA1n7Ch21btHbYyiI3L7Vt9yIHzfGg9w300nk=;
 b=m8OkXRKgIJGSBl3lfI8Kxqt5QBId4v3xk5PDYVH2qONEUz9sNlqDRR3iXizhn24G7N
 j7MvWw4CqMef7zSsiBk1ORYwOGRCNWQfL0aHaASNgoiefx2CjJmD2NCZYa+sDRZPVUUE
 JbYujLQS8TPGW11V75lXRgsSOsW4kjrVHW1QtfIdvELjrIXswwHcUuN30ZbtFJ6pDaRY
 TE75LaMzB/kaK0FtTD2LY/yTyx7/mh5SHOc3UjucV84xQmyUWXeZmpuHckHT0PvcBiKl
 LjkvKzypE6Ckf2Sn/Djye5QExg136Oeq/aNz7gx2FsqdO9yN2b4XRfGW/Gkg1Llnobe5
 yNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9P/IcxoA1n7Ch21btHbYyiI3L7Vt9yIHzfGg9w300nk=;
 b=o2vX3eeYSmpQerolan86mwYs9gKusCnHYmudv+JIgyKA6kyS8rjAnBHjSmn4asaUZ4
 7LMehYkEEy9/DzTC+qtzq00Be/rb2Fuevq0B8V/tuyLjNAeO35S1u7tzBq4PPGlU81K3
 j4z7EhetDSexH8lQJ6xUQJ2Xnknveon96LDXJAvvUJ3GZS6TM6Z/5C/ZzhSyC55leprc
 xZpErN+ax7ouzIYeD/Z9f2irj15PN0pxRHO9FHIPDkaslBwGi/Wff09ifIf1YjHpZtcT
 RurGGz5PEwp9Sh9ydUp5uzYq2IHCWsEfCzpcP/gWpcvFKewdQBHQplocp9/zipMr4rXi
 pwgg==
X-Gm-Message-State: AOAM53209J3GpbBeRuKs9c9Hnn86d1guLV/iwL7vg59PZ8sdl0bNpfwe
 vTUSSGY43hJDX/j4fARyjpARPLOJ/f358w8qrm8=
X-Google-Smtp-Source: ABdhPJzIkqLMqeJyCgHF9scpQUxUQvWHYprHd527Dgl0yKzvh5xOTPphgRUBsiOIPeIz26339mTbjU/0INdGM4sZEoo=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr4034707wmb.56.1606312523924; 
 Wed, 25 Nov 2020 05:55:23 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5t2hMWMDmMZy8y20c_JOOUMcOTeHcukYOKRVriHpAjmw@mail.gmail.com>
In-Reply-To: <CAAxE2A5t2hMWMDmMZy8y20c_JOOUMcOTeHcukYOKRVriHpAjmw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Nov 2020 08:55:12 -0500
Message-ID: <CADnq5_Ns9q0feX8nkEkET25jEiFWifqki6rJcatUFbZLvPBtPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: set LDS_CONFIG=0x20 on VanGogh to fix MGCG
 hang
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QWNrZWQtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KCk9uIFdl
ZCwgTm92IDI1LCAyMDIwIGF0IDE6NDUgQU0gTWFyZWsgT2zFocOhayA8bWFyYWVvQGdtYWlsLmNv
bT4gd3JvdGU6Cj4KPiBQbGVhc2UgcmV2aWV3LiBUaGlzIGZpeGVzIGFuIExEUyBoYW5nIHRoYXQg
b2NjdXJzIHdpdGggTkdHLCBidXQgbWF5IG9jY3VyIHdpdGggb3RoZXIgc2hhZGVyIHN0YWdlcyB0
b28uCj4KPiBUaGFua3MsCj4gTWFyZWsKPgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3Rz
LmZyZWVkZXNrdG9wLm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
