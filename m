Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4742DC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE71864F92
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 08:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE71864F92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=emersion.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6A86E4E3;
	Wed, 17 Mar 2021 08:22:08 +0000 (UTC)
Received: from mail2.protonmail.ch (mail2.protonmail.ch [185.70.40.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112356E4E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 08:22:06 +0000 (UTC)
Date: Wed, 17 Mar 2021 08:21:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail3; t=1615969324;
 bh=PRB6y+3hCSz72FzqyjbDK+6ZhbFhS3aD9wg/Y8a4mAI=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=nIc3390en6hTyI678EO5qEe5OegoYbZurq/tM1lUx1pfbyVoFSbK1r63LdBRZ5HHp
 qligpN80CVIjfSusIJOuVdvMqJJ0Vh/l/AIl0nnBxRKsbpaII2oPpgoB8cgIqtFovH
 j91dpzuT/Lj84986i5RTQC1S5V9vYEoQnZ0bv8MfIBSJ1f1XHr5ujPVYBpRkLrK2/+
 GMibtkJGEq4oGd/0iSzIPZTn1ACnACzpcAFClLj7ozAjl+sXuG3QTPeLoS67AEusyg
 MWF4RfdWEo8ENDzuxsbi3eH6qgJOkGx+RBCiKvGlTYtJclrV3l5JXPVaNaEMnHmGHk
 Pv8S3+Hym0tiw==
To: =?utf-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
From: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v2 0/5] amd/display: improve atomic cursor checks
Message-ID: <gA1HyRXp2aQRPxQEUNKYq1HN64EEpVtJeSsDS0pZEjKlO_gkZWhVKlu7OkjDEFCY9rI52MOV7z0sKUgZ9bomhbHqXr886R9XyH45DX3d8yQ=@emersion.fr>
In-Reply-To: <49db6786-6edc-efb8-45db-80895b55ea90@daenzer.net>
References: <20210310145019.2877-1-contact@emersion.fr>
 <a4fe57bf-33f2-43f5-0170-2135c6a919df@daenzer.net>
 <mg9Sasg2hDaWhKchS7MJOG1GxFgyK7EjamocMRigAuCcwDNJhI5DGVLItXCxyKqNkEl8E2kgsnijtkSMI_YMTe8_Rjmn0Sh8PB32YNTfH1c=@emersion.fr>
 <07f53c21-920d-7494-8195-c678216610a4@daenzer.net>
 <OlOrZse4H1w18QcjDxxswj-tCs1GMJuhZ0S0hYTrcTkXEO-OjALqKgi1vc8hb46TvH9-J3Ri39_qsRHoevbiHgv88dQx8fcWUPKIRrH19KQ=@emersion.fr>
 <49db6786-6edc-efb8-45db-80895b55ea90@daenzer.net>
MIME-Version: 1.0
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
Reply-To: Simon Ser <contact@emersion.fr>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gVGh1cnNkYXksIE1hcmNoIDExdGgsIDIwMjEgYXQgMzoxMyBQTSwgTWljaGVsIETDpG56ZXIg
PG1pY2hlbEBkYWVuemVyLm5ldD4gd3JvdGU6Cgo+ID4gSSdtIG5vdCBhIGZhbiBvZiBhZGRpbmcg
a2VybmVsIGhhY2tzIGxpa2Ugc2V0dGluZyB1cCBhIHRyYW5zcGFyZW50IEZCLCB3aGVuCj4gPiB1
c2VyLXNwYWNlIGNhbiBqdXN0IGF2b2lkIHRoZSBmYWlsdXJlIHdpdGggYXRvbWljIHRlc3Qtb25s
eSBjb21taXRzIChhbmQgZS5nLgo+ID4gdXNlIHRoZSBvdmVybGF5IHRvIGRpc3BsYXkgdGhlIGN1
cnNvciBpbWFnZSBpbnN0ZWFkIG9mIHRoZSBjdXJzb3IgcGxhbmUpLgo+Cj4gSSdtIG5vdCBhIGZh
biBvZiByZXF1aXJpbmcgZWFjaCBhdG9taWMgY2xpZW50IHRvIGhhbmRsZSB0aGlzIGNvbXBsZXhp
dHkuCgpUaGF0J3MganVzdCBob3cgYXRvbWljIHdvcmtzIHRob3VnaC4gVXNlci1zcGFjZSBpcyBl
eHBlY3RlZCB0byBpbmNyZW1lbnRhbGx5CmJ1aWxkIHRoZSBhdG9taWMgcmVxdWVzdCwgYmFpbGlu
ZyBvdXQgaWYgc29tZXRoaW5nIGRvZXNuJ3Qgd29yayBhbG9uZyB0aGUgd2F5LgpEb2luZyBpdCB0
aGUgb2xkIHdheSAoaWUuIGlzc3Vpbmcgc2luZ3VsYXIgYXRvbWljIGNvbW1pdHMsIGllLiB1c2lu
ZyB0aGUgYXRvbWljCkFQSSBqdXN0IGxpa2UgdGhlIGxlZ2FjeSBBUEkgaXMgdXNlZCkgd29uJ3Qg
d29yayBpbiBtYW55IHNpdHVhdGlvbnMgYW55d2F5cy4KClBsdXMsIGEgbGlicmFyeSBzdWNoIGFz
IGxpYmxpZnRvZmYgd2lsbCBqdXN0IGhhbmRsZSBhbGwgb2YgdGhhdCBjb21wbGV4aXR5IGZvcgp5
b3UuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1n
ZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
