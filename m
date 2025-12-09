Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23334D3C529
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 09:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F48510E24D;
	Wed, 10 Dec 2025 09:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=student.kit.edu header.i=@student.kit.edu header.b="VMi5WYYm";
	dkim-atps=neutral
Received: from scc-mailout-kit-01.scc.kit.edu (scc-mailout-kit-01.scc.kit.edu
 [141.52.71.239])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC0D910E1FC
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 15:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=student.kit.edu; s=kit1; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:References:To:From:Subject:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FLmP8ByiKHuqtaZBzq4SchXPYNcZMB4gwIO+EVIUJ6w=; b=VMi5WYYmuPnUmwf+jLwxVYSiWE
 p/e9tH2YAL4HJxlS5BM7huPv7AHcwxPveljfwewk05WqvAfn3dPkQvMmv/6CxlRY7dJXnvQoRnW4I
 kkNBrIlkclzJgtoYqALOpnWZF7IpC7Xb/w8iA48UdVsoQuYTiQJNYRH+QZVqjfbkUKas0Wivdpa2q
 jmk/NVo8ocDc6M5n15p/PwH8EbDyygc1FrM7J/5RJvo/H9ycMnOSWz5FrJuxgUNWBHjQqu/mWhdQl
 44jvQClVg3ml0RgoF5qVzZOU8zQQeNP5p/Vojb6QJ+Kv0xggJ3yirD6IzMMtAp8P4efANPy78iOHi
 pOt07a/w==;
Received: from kit-msx-43.kit.edu ([2a00:1398:9:f612::143])
 by scc-mailout-kit-01.scc.kit.edu with esmtps
 (TLS1.2:ECDHE_SECP384R1__RSA_SHA256__AES_256_GCM:256)
 (envelope-from <peter.bohner@student.kit.edu>)
 id 1vSzzO-0000000AItK-0XwH; Tue, 09 Dec 2025 16:50:58 +0100
Received: from [IPV6:2001:7c7:20e8:134:5275:14f3:3282:3c3]
 (2001:7c7:20e8:134:5275:14f3:3282:3c3) by smtp.kit.edu
 (2a00:1398:9:f612::106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Tue, 9 Dec
 2025 16:50:56 +0100
Message-ID: <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
Date: Tue, 9 Dec 2025 16:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
From: =?UTF-8?Q?P=C3=A9ter_Bohner?= <peter.bohner@student.kit.edu>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 <amd-gfx@lists.freedesktop.org>, <stable@vger.kernel.org>,
 <regressions@lists.linux.dev>, <bugs@lists.linux.dev>, <Jerry.Zuo@amd.com>,
 <aurabindo.pillai@amd.com>, <ivan.lipski@amd.com>, <daniel.wheeler@amd.com>,
 <alexander.deucher@amd.com>, <gregkh@linuxfoundation.org>
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
Content-Language: en-US, de-DE
Autocrypt: addr=peter.bohner@student.kit.edu; keydata=
 xjMEZlcqPBYJKwYBBAHaRw8BAQdAujEt8nGiqXlRzKWzklo/PFVaTiUdA6z4ptXk8gUpZZPN
 LFDDqXRlciBCb2huZXIgPHBldGVyLmJvaG5lckBzdHVkZW50LmtpdC5lZHU+wokEExYIADEW
 IQR4QiuKMuzoE9FfVrf+973rw/xgRwUCZlcqPAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEP73
 vevD/GBH4k4A/jn/XvRQH5Od/m9FpAc3xIwzOjOjFRogJqjNN8h7WGIpAP90BCUs7idkZS/U
 9ASZrK6ubOZV+pEHq9C0mSoVTjwkDc44BGZXKjwSCisGAQQBl1UBBQEBB0AyMulJt5lkL/5E
 hrwAaZiEOSigauCQR7o58Pnzh5hwGAMBCAfCeAQYFggAIBYhBHhCK4oy7OgT0V9Wt/73vevD
 /GBHBQJmVyo8AhsMAAoJEP73vevD/GBHRjYA/0Z40p2r7jZGqQeJB5Exh3sBjLNnuuMw5DXr
 KxFIdY8/AQDj6Xn+3dAOMHJfo17HT8zHn61PvclzVJZCriEmBcSsDQ==
In-Reply-To: <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 10 Dec 2025 09:16:53 +0000
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

note: reverting ded77c1209169bd40996caf5c5dfe1a228a587ab fixes the issue 
on the latest 6.12.y (6.12.61) tag.

