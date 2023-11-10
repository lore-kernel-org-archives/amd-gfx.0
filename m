Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7ADC4167D
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:01:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C798F10E0AB;
	Sun, 12 Nov 2023 18:01:10 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED01110E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 23:32:55 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-40859c466efso18514485e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Nov 2023 15:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699659174; x=1700263974; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PEexQZqE3V4Gt2x3gKRVHcIjmSEfb18+gb5XTY6vv/Y=;
 b=aQBQ7FJo8WGv5cDdGWbJDGXEP8TpZkD376DKCcHuE3A5f1l2HTBvmPR1NQRXD7J9La
 JmgpgP5o7GJWYEgJFDhDDn0zkCsaNHLBgC0Hw/77T0hC0ZLC43+89xyeH6ypJjkhKjj4
 0ZoLEGT/s83igdWwYgAIhQMiSXP5qb3BWL885jMEUH42ecYixd6gJs2Hy3Px2mvf1aa/
 nQqtGODw01DDIQv0VgbAwCCHLZ5gc06F/boYW71xPFQ4FENaR8WhXwZmwPzq9SrhfeR+
 3MscmhPTfXzNQBWK1+15OiRoTpvKh4oCS5DJAbjYgHqDrKxzrVivQDrkOQtLPW8BxL9E
 lgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699659174; x=1700263974;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PEexQZqE3V4Gt2x3gKRVHcIjmSEfb18+gb5XTY6vv/Y=;
 b=flc/r5X5/jDqFZuLtTsv9i4mWOTUqhmRgSw83/KUULAJY0IV9rDSDQjEzJx71KNRfv
 AWyhTJzoY+7u8UKE1GAwBsAKsNMg4L9ZhPgKLK52nle5tFvXWZC4pF+pYlKZUBrqiyw7
 fHwtUjlDk7I4c2+c0UF/Ko3+mv97d9c4MpJeFrBhkwc7tbgKhMciyehtnzKjingi4SXJ
 39ylHiALrYbMjPQzRjb9d0nraoFN6BZGVVMgSG/7IB1VPmw6snQGkRPVmI7VNqkUzgjn
 mCFBnc3If5S8ct9NYnwZ4YU9aaxoJ7+VPHx9hEEkkjKCjQtdDFX9qZ8UkFfqkcGV35iq
 Pj3A==
X-Gm-Message-State: AOJu0Yweud2Ii79BuKeEIEwjhk/5L4bxkxT1HzrUXAvbFqZB3VIED6g7
 qhUkoQZfc8K+A5UqaZTKZQaVEhmE4VAH1ZPgxYhOnPGRrg7bijaX
X-Google-Smtp-Source: AGHT+IEPhz/A9Po6wc880pzJiye6WJvVY8UfQTfT8mNcW3Mb4kql2Ay7GSXJuuoox8sJJ0MKaKEWGMz0CWl4cfGOp6I=
X-Received: by 2002:a05:6000:18a6:b0:32f:8ace:f0b7 with SMTP id
 b6-20020a05600018a600b0032f8acef0b7mr515393wri.12.1699659174073; Fri, 10 Nov
 2023 15:32:54 -0800 (PST)
MIME-Version: 1.0
From: J Fra <jfra4799@gmail.com>
Date: Fri, 10 Nov 2023 17:32:34 -0600
Message-ID: <CAE584xY3twxGyvF+Ep3a_3vtAEA_ZoObUAKjE=rTRjd4HsvtAA@mail.gmail.com>
Subject: Re: [PATCH v7d 02/23] dyndbg: reword "class unknown,
 " to "class:_UNKNOWN_"
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="0000000000004f5a6e0609d4bdc5"
X-Mailman-Approved-At: Sun, 12 Nov 2023 18:01:09 +0000
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

--0000000000004f5a6e0609d4bdc5
Content-Type: text/plain; charset="UTF-8"



--0000000000004f5a6e0609d4bdc5
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--0000000000004f5a6e0609d4bdc5--
