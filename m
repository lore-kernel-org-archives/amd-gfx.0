Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188DCC47073
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jan 2024 08:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B57C410E168;
	Mon,  8 Jan 2024 08:41:11 +0000 (UTC)
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch
 [185.70.41.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757BB10E162
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jan 2024 04:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1704687566; x=1704946766;
 bh=Lpzrw5NlfrQyFWNOAIlvxkLWdpHsFRaoLrShLGObqgE=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=jZ8IvnJcOjMy6LSttFjbZlVxf8ZPUbR40gLUEBd/E6usuM+xzgCdLtELpIgYLLlOW
 7Pc5c5XHu5uTlWtVgIMNlWv/UHa6HvrhQzkqd8YWs7D+JqVXpeD1HwEtqiCdZZKEkT
 o9vyJM3s5SbIoY8r7s39VubeGH3N8BUtdmTB14KLqEfI7dTfnhtc8qorTZOJuvJiU/
 24ksj3oBDGRSIBix5aiYeL3VgmQp/yEEpop0J0z9mK9RR7mSoVxlgCaH1Z14J8uOoy
 cvIhtk4icKu0jWFCqd+hXafQf/NB02rrWg/bh9eYXjRSxV7SdjpGW9IEf5FQd5r+D2
 xlAwq06vjMcUw==
Date: Mon, 08 Jan 2024 04:19:18 +0000
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Alexander Koskovich <AKoskovich@protonmail.com>
Subject: Documentation for RGB strip on RX 7900 XTX (Reference)
Message-ID: <oCYzPIgXFcQ3jdqAKY2upsY5qq23yOba06RkrzD5Bfai97jMWxGvBsaOiKi1k5oZvNg7IoJLE6jAA6BLGFXt08WbBEtdgJA4snn7khZ0JFM=@protonmail.com>
Feedback-ID: 37836827:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 08 Jan 2024 08:41:10 +0000
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

I was wondering if AMD would be able provide any documentation for the RGB =
strip on the reference cooler (https://www.amd.com/en/products/graphics/amd=
-radeon-rx-7900xtx)? It looks to be handled via I2C commands to the SMU, bu=
t having proper documentation would be extremely helpful.

Thanks
