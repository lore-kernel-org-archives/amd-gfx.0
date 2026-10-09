Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F003FCA601A
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 08:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA12410FF69;
	Fri,  9 Oct 2026 08:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C5+KFltK";
	dkim-atps=neutral
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com
 [209.85.221.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E9B10EA70
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 03:03:37 +0000 (UTC)
Received: by mail-vk1-f170.google.com with SMTP id
 71dfb90a1353d-5e78346891fso1768605e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791515016; x=1792119816; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
 b=C5+KFltKRZUW2VJuaWWPfi/EC4aV8/umtSNjTzy4K3owe3AdmtsHmqPBB4jfHScUFc
 JpgCMsuiCbskkTCQ9ysEOjc/yDEPWEiXcpdLBH2hXWID60kjmwUMEeHksTzSP84uB/72
 pTm1EoIX+q75+NPOGQOoecOE1oqV2G1O/BtynIP3PysXKpVRGYcnCBV+DQlNqzxIUofx
 +YvfOXyvpe6gUMibChku0PiTfHVCHeIzhtZQ2fszOxccyJmYEoP8ufWf/EKKISgffKY0
 Tokd79VzuV089pb3TC/FmcV4MdNwxLVWxlERw9udoQH20EByKtXtXEPoQdpFBryU5odb
 l1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791515016; x=1792119816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dY+07CnYbuDTOMQpTAwDubObYAClkAAr9Kwvv3Zr0Ig=;
 b=El+Iis8mdIKQ5l9wBUFtY9Wx6wMNq1JWSIY+KJIfh8ZZFpHtg/aaleKutD7Msdq/N7
 9P7IZ25RrAtZRqVL1kuiGTYaN9eEhGDkQ2JA4nMhNDC6NfnseNKGR+fCQ0U7bEWapwDP
 2YsLmL1VB3AUhEGslHoWrzK1TTVFcEXvOgwRrFoc7a59E/k9l4KM8YXl1rBET8tzYxjl
 9edUM7NQV4nWNkSEOSGX5+MP4wq3i+0dtmur4gdKfqauo4i/LiG8mlvi3Q5cNj0VyUUm
 M98tUyGEwiXjQFNTjiQ85Rxdqz9myRvZhLX/ytmRAf3VignnTWCYevRpIXvSEVO45cU6
 R6TA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxj0ToWy0nrkv3/knVtr9VuZrhU0aTfjxjb2k/8ii4vbSVyPBqfXnNzXuB0YspCLNNmiPlhZGqo@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLI1RGW0Euw0N6v+X5/anDgUxXxJ7nHZtcGMudJCpyV7B3VlAVr
 9tontkPIPXrGIqkRR+cX0VKbBT9XE1GC7Wnylj9jFQrVMnDDX7YubGtU
X-Gm-Gg: AYBFou0fKQa5KqxnSErr1Ekayl4b4tWqYntNhCqZFRYT0WCJmJ/Wwl0zI5H2Ige92W5
 ggLqCdmS6s4yuYN0bNaFy5+d9yoBLHOO7OFGBbxvp9fQjA9zVswrYwJuyaUmh3dsmg/knWaydAm
 LyFJAgrUDKQT0RiwayPWFy8s3gtwrWfMqtMh8UfdUtzcMI3nVF9iPewediq19bvvKgGVDgo4uPn
 1y4vTqBfiN7aP9d5SMtLU9EVbCGKSk7JBArTyCvbvw67kcIe17JGqBPhsflUGTgATpnPF9iEblH
 AtM0UDy/THsV37wUofpLeDtkXWyAaxEzJTDfHc+P855K9gchl46SefBmQ77UBzOKDZot3Hpd4Nh
 +U4GQiwhdrF6mRS3xbP6cTN64Zu88c+sSZZ7OvHRPgiYg4321g0Y2lVY17/wSQyVjQjfhpZUAhi
 F8u6s3/J1876jbYRAs8T9DxVxMdDNG6XC6Zkit3MtG1WUGv7uZoqyp0110mrv1vtE=
X-Received: by 2002:a05:6102:548f:b0:7c3:83a9:edcd with SMTP id
 ada2fe7eead31-7cb397160f4mr227448137.3.1791515016575; 
 Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
Received: from beelink.. ([187.13.210.57]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-99003ae1577sm814626241.0.2026.10.08.20.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 20:03:36 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?q?K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: fix ATOM parameter space index bounds check
Date: Fri,  9 Oct 2026 00:03:27 -0300
Message-ID: <20261009030328.3062630-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923162839.1368073-1-qwe.aldo@gmail.com>
References: <20260923162839.1368073-1-qwe.aldo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 09 Oct 2026 08:12:18 +0000
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

Hi Alex,

Friendly ping on this v2, sent September 23.  It fixes the dword/byte
mismatch in the ATOM PS index bounds check in atom_get_src_int() and
atom_put_dst() -- the sibling of the calltable underflow fix you
already applied.

v2 also corrects the pr_info() messages to print ps_size/4 (dwords)
instead of ps_size (bytes), per Sashiko review on v1.

Thanks,
Aldo
