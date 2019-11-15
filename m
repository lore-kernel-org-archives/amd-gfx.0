Return-Path: <SRS0=FndT=ZH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82290C432C3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 01:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0382071B
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2019 01:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0382071B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0001A6F3A9;
	Fri, 15 Nov 2019 01:43:03 +0000 (UTC)
Received: from mx0-44.i-mecca.net (mx0-44.i-mecca.net [76.74.184.194])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE6736F3A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2019 01:43:02 +0000 (UTC)
Received: from mx0.ehosting.ca (localhost [127.0.0.1])
 by mx0.i-mecca.net (Postfix) with ESMTP id 56EE3161F1F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 17:43:02 -0800 (PST)
Received: from ns14.i-mecca.net (unknown [192.168.1.14])
 by mx0.i-mecca.net (Postfix) with ESMTP id 25645161EC2
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 17:43:01 -0800 (PST)
X-MES: 1.0
Received: from [192.168.1.77] (d75-157-136-133.bchsia.telus.net
 [75.157.136.133])
 by ns14.i-mecca.net (Postfix) with ESMTPSA id E656814043E
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2019 17:42:59 -0800 (PST)
Subject: Re: [Regression] Broken Raven Ridge firmware on kernel 5.3.11 and up
To: amd-gfx@lists.freedesktop.org
References: <05ccc016-243e-a1de-10e1-e7ad19605baa@fedoraproject.org>
 <CADnq5_PxdXv3FchuDyjXcUTmCkpK6n0XBvoyx99FNztxfj4sLA@mail.gmail.com>
From: Luya Tshimbalanga <luya@fedoraproject.org>
Organization: Fedora Project
Message-ID: <1f5e46bf-9b9a-99dc-c510-6b16115cb50e@fedoraproject.org>
Date: Thu, 14 Nov 2019 17:42:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CADnq5_PxdXv3FchuDyjXcUTmCkpK6n0XBvoyx99FNztxfj4sLA@mail.gmail.com>
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
Message-ID: <20191115014259.BRdXpkumioLuTiLB61jqBaVNiAiaFYLVCDj8Ea_tGvc@z>

VGhhbmtzIEFsZXggZm9yIHRoZSBxdWljayByZXBseS4gVGhlIGtlcm5lbCBpbiBxdWVzdGlvbiBp
cyBmcm9tIEZlZG9yYSAKdGhhdCBzb21laG93IGZhaWxlZCB0byBpbnN0YWxsIHRoZSBmaXJtd2Fy
ZSBpbiB0aGUgaW5pdHJkLiBUaGUgZmlybXdhcmUgCmlzIHByZXNlbnQgYXMgaGlnaGxpZ2h0ZWQg
b24gdGhlIGJ1Z3ppbGxhIApodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dp
P2lkPTE3NzIzMTMjYzQKCkF3YWl0aW5nIGZvciB0aGUgRmVkb3JhIEtlcm5lbCB0ZWFtIHRvIGlu
dmVzdGlnYXRlIHRoZSByb290IGNhdXNlLgoKCk9uIDIwMTktMTEtMTQgNjo0OSBhLm0uLCBBbGV4
IERldWNoZXIgd3JvdGU6Cj4gT24gVGh1LCBOb3YgMTQsIDIwMTkgYXQgMTozNCBBTSBMdXlhIFRz
aGltYmFsYW5nYQo+IDxsdXlhQGZlZG9yYXByb2plY3Qub3JnPiB3cm90ZToKPj4gSGVsbG8gdGVh
bSwKPj4KPj4gSSBmaWxlZCBhIGJ1ZyBvbiB0aGUga2VybmVsIHdpdGggYSBicm9rZW4gUmF2ZW4g
UmlkZ2UgZmlybXdhcmUgcmVzdWx0aW5nCj4+IGEgYmxhbmsgc2NyZWVuIHRodXMgdW5hYmxlIHRv
IGJvb3QgdG8gZWl0aGVyIGdyYXBoaWNhbCBhbmQgdGV4dCBtb2RlLgo+PiBDb3VsZCBzb21lb25l
IGludmVzdGlnYXRlIHRoZSBpc3N1ZSBvbjoKPj4KPj4gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwu
b3JnL3Nob3dfYnVnLmNnaT9pZD0yMDU1MjEgd2hpY2ggaW5jbHVkZSB0aGUKPj4gZG1lc2cgbG9n
Cj4+Cj4+IFRoZSBmaXJtd2FyZSBzdGlsbCB3b3JrcyBvbiBrZXJuZWwgNS4zLjkgSSBjdXJyZW50
bHkgdXNlLgo+IFRoZSBrZXJuZWwgaXMgbm90IGFibGUgdG8gZmluZCB0aGUgZmlybXdhcmUuICBQ
bGVhc2UgbWFrZSBzdXJlIHRoZQo+IGZpcm13YXJlIGlzIGluIHRoZSBpbml0cmQgaWYgdXNpbmcg
b25lLCBvciBpbiB0aGUga2VybmVsIGlmIHlvdSBidWlsdAo+IHRoZSBkcml2ZXIgaW50byB0aGUg
a2VybmVsLgo+Cj4gQWxleAo+Cj4+Cj4+IFRoYW5rcyBpbiBhZHZhbmNlLgo+Pgo+PiAtLQo+PiBM
dXlhIFRzaGltYmFsYW5nYQo+PiBGZWRvcmEgRGVzaWduIFRlYW0KPj4gRmVkb3JhIERlc2lnbiBT
dWl0ZSBtYWludGFpbmVyCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCj4+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4+IGFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCj4+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlz
dGluZm8vYW1kLWdmeAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+IGh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeAoKLS0gCkx1eWEgVHNoaW1iYWxhbmdhCkZlZG9yYSBEZXNpZ24gVGVhbQpGZWRvcmEgRGVz
aWduIFN1aXRlIG1haW50YWluZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1k
LWdmeA==
