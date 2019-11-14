Return-Path: <SRS0=uNvg=ZG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696CCC432C3
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 06:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B8620709
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2019 06:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B8620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7616E05D;
	Thu, 14 Nov 2019 06:34:47 +0000 (UTC)
X-Greylist: delayed 392 seconds by postgrey-1.36 at gabe;
 Thu, 14 Nov 2019 06:34:45 UTC
Received: from mx0-44.i-mecca.net (mx0-44.i-mecca.net [76.74.184.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA2CB6E05D
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 06:34:45 +0000 (UTC)
Received: from mx0.ehosting.ca (localhost [127.0.0.1])
 by mx0.i-mecca.net (Postfix) with ESMTP id 545BE162BE6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:28:11 -0800 (PST)
Received: from ns14.i-mecca.net (unknown [192.168.1.14])
 by mx0.i-mecca.net (Postfix) with ESMTP id A7FB2162BE1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:28:10 -0800 (PST)
X-MES: 1.0
Received: from [10.0.9.15] (unknown [184.69.65.194])
 by ns14.i-mecca.net (Postfix) with ESMTPSA id 9B6B014043E
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2019 22:28:09 -0800 (PST)
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
From: Luya Tshimbalanga <luya@fedoraproject.org>
Subject: [Regression] Broken Raven Ridge firmware on kernel 5.3.11 and up
Organization: Fedora Project
Message-ID: <05ccc016-243e-a1de-10e1-e7ad19605baa@fedoraproject.org>
Date: Wed, 13 Nov 2019 22:28:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Language: en-CA
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191114062809.nAvVWWbT9785d4Mswyh5I6PGOBLpavsevld4_mMB5IQ@z>

SGVsbG8gdGVhbSwKCkkgZmlsZWQgYSBidWcgb24gdGhlIGtlcm5lbCB3aXRoIGEgYnJva2VuIFJh
dmVuIFJpZGdlIGZpcm13YXJlIHJlc3VsdGluZyAKYSBibGFuayBzY3JlZW4gdGh1cyB1bmFibGUg
dG8gYm9vdCB0byBlaXRoZXIgZ3JhcGhpY2FsIGFuZCB0ZXh0IG1vZGUuIApDb3VsZCBzb21lb25l
IGludmVzdGlnYXRlIHRoZSBpc3N1ZSBvbjoKCmh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9z
aG93X2J1Zy5jZ2k/aWQ9MjA1NTIxIHdoaWNoIGluY2x1ZGUgdGhlIApkbWVzZyBsb2cKClRoZSBm
aXJtd2FyZSBzdGlsbCB3b3JrcyBvbiBrZXJuZWwgNS4zLjkgSSBjdXJyZW50bHkgdXNlLgoKClRo
YW5rcyBpbiBhZHZhbmNlLgoKLS0gCkx1eWEgVHNoaW1iYWxhbmdhCkZlZG9yYSBEZXNpZ24gVGVh
bQpGZWRvcmEgRGVzaWduIFN1aXRlIG1haW50YWluZXIKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlz
dHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4v
bGlzdGluZm8vYW1kLWdmeA==
