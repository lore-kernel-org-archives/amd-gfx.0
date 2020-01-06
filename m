Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25A9C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:59:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE52020731
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 19:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKpVdxpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE52020731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 795C76E50D;
	Mon,  6 Jan 2020 19:59:21 +0000 (UTC)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEFE96E507
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2020 19:34:23 +0000 (UTC)
Received: by mail-lf1-x132.google.com with SMTP id y1so37116760lfb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jan 2020 11:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-transfer-encoding:content-language;
 bh=wHg9BQSYJ1iv668A+G5b+aCAzAM8VnC+/2s2A3OHhLY=;
 b=DKpVdxplYbaSfjlgb8fV6p0EbMX0BkWfeifbUIoTSWvCahtu9l/wF25B8p98n8SD7P
 iaXyF2sarejCUcz+z0g580oGJPjF6cHrG1xHh8tbNQCQl2tN3AUIDb4X0WmpCjStdn4J
 uoLJe8n64tgtc7JHvegMn6/GydoH9fZg0vuVFcTN/CDIG4MbJNROgDYjewe5DAgLAFOq
 ZwkLtZ1ZAG0exR2ugl7Btjrrv5wXRGafhmWjW3mGiFYAufIG2yk29cCPL0pNPLgBiLWJ
 tqW0jN6zkVDRvGKIB/fJAgM8ZUhQEvPR6tzfjlYpqvkIY4Kqd51dLdM+Npov6AQ8+Ng+
 hA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-transfer-encoding:content-language;
 bh=wHg9BQSYJ1iv668A+G5b+aCAzAM8VnC+/2s2A3OHhLY=;
 b=RQB0FPz50Jjvi/40ptnqLsxTxpONrTEIWgPWO4Dze04stV4McEvrl4QG6ZENa6J8zP
 Wo44J191zE9X3fq9ugEjvvRoXMN023vbMsA0vVHr9OlWn+Xz1H9h1819g+UIW9TCrN1K
 vMcGY8euid+WFVpbl+0vSfb5bv4mQf/5JrEqC8VYDWeIEsf3MXwE89oT31Df1zAsK4di
 Ub4MXvTWQ2e9gbpA3yp3PTnyUJwEBAn9LiUL6DZNAexZulMyBDZRowJ9YOWdJM6D2mhy
 HXDbrsBeIFdIJrJL6eyzueYFN76/VOAhrgOAtBlGaQjmS7U9b5i1kS5wub6LwCzwbc6s
 EsMg==
X-Gm-Message-State: APjAAAU+xXrk8NVknkFSo4Y7PrxjEW9fRbSWvDJPbrIDYwHgSPiBYIM5
 5cXx158YdvlWwvKtvM7/3EA5aZ6/
X-Google-Smtp-Source: APXvYqyzAgY1mMko4KOEY88RpWh0gbOlGXO3LwAYIyvhPvQprqWgY7Ssf2Fkd2q69jC2h8Uly4GcvQ==
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr56872649lfg.117.1578339261563; 
 Mon, 06 Jan 2020 11:34:21 -0800 (PST)
Received: from [192.168.0.11] (c83-252-246-74.bredband.comhem.se.
 [83.252.246.74])
 by smtp.gmail.com with ESMTPSA id q26sm29315954lfc.52.2020.01.06.11.34.20
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 11:34:20 -0800 (PST)
To: amd-gfx@lists.freedesktop.org
From: =?UTF-8?Q?Martin_B=c3=a5ngens?= <marbangens@gmail.com>
Subject: Problem whit Radeon rx 590 makes games crash on Linux
Message-ID: <b4065e11-fd22-21af-8638-b33ff344304c@gmail.com>
Date: Mon, 6 Jan 2020 20:34:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
Content-Language: en-US
X-Mailman-Approved-At: Mon, 06 Jan 2020 19:59:21 +0000
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi AMD graphic driver developer for Linux!

I have problems with playing games using Linux opensource driver

I have xfx radeon rx 590 fatboy and tested with proprietary driver games 
run fine but too slow for playing

here is bit more info about my experience

ask me anything


https://community.amd.com/thread/246894

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
