Return-Path: <SRS0=r3ut=A7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C7C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 08:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C042176B
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2020 08:46:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Fo5nVQGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C042176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 778916E1E2;
	Mon, 20 Jul 2020 08:46:28 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3390D6E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595234783;
 bh=U3rdwQL12a1xWmYcfqNR/odj+8cVsmCzQ62DAmJYyG0=;
 h=X-UI-Sender-Class:Reply-To:Subject:To:References:From:Date:
 In-Reply-To;
 b=Fo5nVQGXxVQ1OYzdao+6dnsNx/Bmc1AUtNr/s98chvYse5d/xX3cfHDzGHjzFu6cF
 6N/Zucr7Es+gf0T9eyyeNhlFYUGz6k/pQlStxHV9Zgjb2gvDtaA3YzzcKm/O9ZTNWw
 fEf9xLJS7QB4QzoEMsDsLKDnDHvwpx3KDNsOZd2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.5] ([178.27.135.239]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MN5iZ-1kDbFC0RFt-00Izkn for
 <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2020 10:46:23 +0200
Subject: Re: Amdgpu kernel oops and freezing graphics
To: amd-gfx@lists.freedesktop.org
References: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
From: Harvey <harv@gmx.de>
Message-ID: <5e484fd8-5e79-d6ee-c3e2-14a05f49ef74@gmx.de>
Date: Mon, 20 Jul 2020 10:46:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44e135ed-dfb7-533f-3c55-8e852a349762@gmx.de>
Content-Language: de-DE
X-Provags-ID: V03:K1:OTXkX/l5iCJm3eNVSOGNPgbuH8PSd5TP27vl4iHufwkolMsbZTl
 cn6sISPecBbmzv+PiCrXjKLZSQDnByiAan1T7yAIdS6W+KtLnS48JHSx3gecrtIjv9FnVPq
 PSk4GrNO8qr4I8ZiPCQJWLydaaHSNBSkJqo0GwWdTheCIo2zvfs0ggPjbX0Mo9DFqBVRAqo
 q/+3FWbYGeTf4vcqi1Hew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XdgUKD1PeoI=:iLe86lKn0eow0bhwOT1NWM
 /7uxYyq+wH3IGHJRttyTgOewd+LRKGWRMGiurmwenCYPV4af5FYoulv6c40guEr7hmRRHYrqR
 FVtEN2aRJMIiXDZ0sVxTVq8udaGVwJSf6xJUS0CFd1rCWxm39vvUVNb/sVHmAl79d3CkTtew+
 6r7a54yW3Nc6GMWXk2lLJyEzDXBvi69NV5jB5VHSwTJMC3uZP7pL47gvoeZosz/oa1hcn7Qtr
 fDQyJDbOPuZL7nvB6KMivWBvmUsDs1tAOtm56JoKpK14kfMUYfkXHC0RS/Dub+KI5Oa/1RG+F
 hKsDp3WWo/8gDRx4k02RwBczjEWepiOa5w7CvlMnldE/t94ACNO1XAOyJR1Cck1HnFX/XqAX8
 MW1lNHbt8laTqAIBkoI/cJ9SDCN/UsfN1HX0pJj+Rn9gI62pGW6B/y8dBhO/zgrCbpZP0HFdl
 WhH1/9iVUi3epuMFqU2N0hdIbMIBfZJUqGLKV/DtMy51489mo6Ek00+vf8xuuHydLOul50qPY
 AmuFBzOqjfrVNbqyFSEUGj3Rs9ZWjp5mq5zhrLCCS0YNsU2TfCEuIrV0waBqAUMDdW4QQzUXa
 IiAjDrICW38SDajc2vvpyqPJwljnD7SxzjeD4RVN2lY2ooxz/o81e4XBa0vBugi99nzyTDIdt
 ZhLQ/o7fjGTDWz2G9P+YP9UXbznPkGMQup7wHCpvnapLh+FhbeKjM9NM1U4wjpKbnXW2y0j8p
 quantLhD6MbcaNxi6ZAdWW3snpGmIR0w1l4aSpKZdnPomODLm3ubBThcQq9IjQzCBGcfMm0D1
 nFuuFp88oCwdWx6kAY5qblsuW5H1Hp3rq7d0Nhkihpg/w7qWgjCGfehEPHueJzrFgWR8O+qk6
 fLhBthFe+DVe+heSGcj81L0gi64K7NsNI+fHvt/HWD6qN1FMYaX/VctN+MhVLXUwlJVmTKeHU
 uxNQB78hgdoyvp1wMFjeAmBY1/eBV7Lw3O59RsxdYr2X4x6uAPHGzibDqkr5r40wWOrulocgL
 GPgnGMTourW1fYLy4lroIhtc+e/eH9IBo4Szb5wnWyOPOWSaFBt2VW4eFmfU2x5j80GTaeyLa
 rb94hLFAY+MahcUrxiA3iGv6aANUPohPwmc41mWmtxpkvsUKnSGxI75EWMhVBZv3XWRA0Oz80
 mMr6nxpSXHxvmGRJD4vHAG+NM1wWcpZDpTpgyubRR9fT15LgRu8qDbpkLivJoNAQH4nWZ+ecr
 I+zqSlbLpneNxwudS
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
Reply-To: harv@gmx.de
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Jack

first, thanks for the answer

 > RX 5500m only has win10 support.
I have seen that (well - too late, I admit). But I would be perfectly
happy with the processor graphics of the 4800U. I bought the laptop
because of the 17 inch display in first place. If there would be a way
just to switch the 5500m off that would be perfectly enogh. I'm not a
gamer...

But AFAIK there is no way to do this without the kernel oopsing. I
thought it would be possible to make the machine usable at least...

Greetings
Harvey

--
I am root. If you see me laughing, you'd better have a backup!
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
