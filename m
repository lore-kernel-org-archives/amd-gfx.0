Return-Path: <SRS0=Vl9p=Y4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E821CA9EC9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 23:58:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52175206B8
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Nov 2019 23:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52175206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nuetzel-hh.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C1B6E8BB;
	Mon,  4 Nov 2019 23:58:32 +0000 (UTC)
Received: from mail.ud03.udmedia.de (ud03.udmedia.de [194.117.254.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 059D66E8BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Nov 2019 23:58:29 +0000 (UTC)
Received: (qmail 931 invoked from network); 5 Nov 2019 00:58:27 +0100
Received: by mail.ud03.udmedia.de with ESMTPA; 5 Nov 2019 00:58:27 +0100
X-UD-Smtp-Session: ud03?335p7@P1SJF46Wmq7Cdf4e
MIME-Version: 1.0
Date: Tue, 05 Nov 2019 00:58:27 +0100
From: =?UTF-8?Q?Dieter_N=C3=BCtzel?= <Dieter@nuetzel-hh.de>
To: Alex Deucher <alexdeucher@gmail.com>, Pierre-eric Pelloux-prayer
 <Pierre-eric.Pelloux-prayer@amd.com>, Harry Wentland
 <Harry.Wentland@amd.com>
Subject: Power consumption of Navi and Polaris
Message-ID: <b0b99b9be6b0526b0cf4b64f2d5bfd6a@nuetzel-hh.de>
X-Sender: Dieter@nuetzel-hh.de
User-Agent: Roundcube Webmail/1.3.10
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=nuetzel-hh.de;
 h=
 mime-version:content-type:content-transfer-encoding:date:from:to
 :cc:subject:message-id; s=k1; bh=3ZNExMAqxTvfvYGutpsQl9hqFDaNgB1
 GSg6ITfbAtwE=; b=DLEnnkakjphGtriDTiQU8+VVuPkEhz9Oc5klv9zN0gaZknB
 5RUAzlK+sBsP2j0RkFC9LHhjqjbdmah28ARkP9ozYahBzBr9TlZlq9loTKMWeeBO
 GwIkNtQQabRbDd9rPMyVtrgHnyFbhrjhCSSmHxI2P0jxsyyGvhVp7x8Ati1U=
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: amd-devel <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191104235827.ROLVmNgf15w8MBsCkRdJVbeTp60nWaPxejkBNXQg7jE@z>

SGVsbG8gQWxleCBldCBhbC4sCgpjYW4geW91IHBsZWFzZSBoYXZlIGEgbG9vayBhdCB0aGlzIGJ1
ZyByZXBvcnQgYW5kIGZpbmRpbmdzPwoKU2FwcGhpcmUgUHVsc2UgUlggNTcwMCBYVCBwb3dlciBj
b25zdW1wdGlvbgpodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0x
MTE0ODIKZS5nLgpodHRwczovL2J1Z3MuZnJlZWRlc2t0b3Aub3JnL3Nob3dfYnVnLmNnaT9pZD0x
MTE0ODIjYzMwCgpUaGFua3MsCkRpZXRlcgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZng=
