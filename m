Return-Path: <SRS0=4FJE=CL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C6C433E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 20:44:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16ED620767
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2020 20:44:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16ED620767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B536E504;
	Wed,  2 Sep 2020 20:44:58 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D9E6E0CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2020 20:27:37 +0000 (UTC)
IronPort-SDR: jqYrYly8G5ci0NqJRw4cJYL/b1QXGNWYG87OVn2LTRN1NkfW6nZeB9jA1JXgvSyJx8Z1Kq941z
 UB2og/iZpV8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="145165758"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="145165758"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP; 02 Sep 2020 13:27:36 -0700
IronPort-SDR: GtBaKznKuR1LXoE174x3vfConIS+Tpxs9ge1e1K5AjFcCBVFmOeBnEg7ukNML0z3SYSPeknflT
 Fp5p/u90DafA==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="325925854"
Received: from acduong-mobl2.amr.corp.intel.com (HELO [10.254.87.179])
 ([10.254.87.179])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 13:27:36 -0700
Subject: Re: [PATCH v4 8/8] Revert "PCI/ERR: Update error status after
 reset_link()"
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-pci@vger.kernel.org
References: <1599072130-10043-1-git-send-email-andrey.grodzovsky@amd.com>
 <1599072130-10043-9-git-send-email-andrey.grodzovsky@amd.com>
 <75db5bfb-5a53-31cf-8f89-2a884d6be595@linux.intel.com>
 <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
From: "Kuppuswamy, Sathyanarayanan"
 <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <d4da4c2c-4fdb-08ee-c514-acfbcb67e16b@linux.intel.com>
Date: Wed, 2 Sep 2020 13:27:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a3cadf36-d597-97fe-a096-83baa73c6f8f@amd.com>
Content-Language: en-US
X-Mailman-Approved-At: Wed, 02 Sep 2020 20:44:57 +0000
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
Cc: nirmodas@amd.com, bhelgaas@google.com, luben.tuikov@amd.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, Dennis.Li@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

CgpPbiA5LzIvMjAgMTI6NTQgUE0sIEFuZHJleSBHcm9kem92c2t5IHdyb3RlOgo+IFllcywgd29y
a3MgYWxzby4KPiAKPiBDYW4geW91IHByb3ZpZGUgbWUgYSBmb3JtYWwgcGF0Y2ggdGhhdCBpIGNh
biBjb21taXQgaW50byBvdXIgbG9jYWwgYW1kIHN0YWdpbmcgdHJlZSB3aXRoIG15IHBhdGNoIHNl
dCA/Cmh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTE2ODQxNzUvbWJveC8KPiAK
PiBBbGV4IC0gaXMgdGhhdCBob3cgd2Ugd2FudCB0byBkbyBpdCwgd2l0aG91dCB0aGlzIHBhdGNo
IG9yIHJldmVydGluZyB0aGUgb3JpZ2luYWwgcGF0Y2ggdGhlIGZlYXR1cmUgCj4gaXMgYnJva2Vu
Lgo+IAo+IEFuZHJleQo+IAo+IE9uIDkvMi8yMCAzOjAwIFBNLCBLdXBwdXN3YW15LCBTYXRoeWFu
YXJheWFuYW4gd3JvdGU6Cj4+Cj4+Cj4+IE9uIDkvMi8yMCAxMTo0MiBBTSwgQW5kcmV5IEdyb2R6
b3Zza3kgd3JvdGU6Cj4+PiBUaGlzIHJldmVydHMgY29tbWl0IDZkMmM4OTQ0MTU3MWVhNTM0ZDYy
NDBmNzcyNGY1MTg5MzZjNDRmOGQuCj4+Pgo+Pj4gSW4gdGhlIGNvZGUgYmVsbG93Cj4+Pgo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGNpX3dhbGtfYnVzKGJ1cywgcmVwb3J0
X2Zyb3plbl9kZXRlY3RlZCwgJnN0YXR1cyk7Cj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAocmVzZXRfbGluayhkZXYsIHNlcnZpY2UpICE9IFBDSV9FUlNfUkVTVUxUX1JFQ09W
RVJFRCkKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXR1cyA9IHJlc2V0X2xp
bmsoZGV2LCBzZXJ2aWNlKTsKPj4+Cj4+PiBzdGF0dXMgcmV0dXJuZWQgZnJvbSByZXBvcnRfZnJv
emVuX2RldGVjdGVkIGlzIHVuY29uZGl0aW9uYWxseSBtYXNrZWQKPj4+IGJ5IHN0YXR1cyByZXR1
cm5lZCBmcm9tIHJlc2V0X2xpbmsgd2hpY2ggaXMgd3JvbmcuCj4+Pgo+Pj4gVGhpcyBicmVha3Mg
ZXJyb3IgcmVjb3ZlcnkgaW1wbGVtZW50YXRpb24gZm9yIEFNREdQVSBkcml2ZXIKPj4+IGJ5IG1h
c2tpbmcgUENJX0VSU19SRVNVTFRfTkVFRF9SRVNFVCByZXR1cm5lZCBmcm9tIGFtZGdwdV9wY2lf
ZXJyb3JfZGV0ZWN0ZWQKPj4+IGFuZCBoZW5jZSBza2lwaW5nIHNsb3QgcmVzZXQgY2FsbGJhY2sg
d2hpY2ggaXMgbmVjZXNzYXJ5IGZvciBwcm9wZXIKPj4+IEFTSUMgcmVjb3ZlcnkuIEVmZmVjdGl2
ZWx5IG5vIG90aGVyIGNhbGxiYWNrIGJlc2lkZXMgcmVzdW1lIGNhbGxiYWNrIHdpbGwKPj4+IGJl
IGNhbGxlZCBhZnRlciBsaW5rIHJlc2V0IHRoZSB3YXkgaXQgaXMgaW1wbGVtZW50ZWQgbm93IHJl
Z2FyZGxlc3Mgb2Ygd2hhdAo+Pj4gdmFsdWUgZXJyb3JfZGV0ZWN0ZWQgY2FsbGJhY2sgcmV0dXJu
cy4KPj4+Cj4+IMKgwqDCoMKgfQo+Pgo+PiBJbnN0ZWFkIG9mIHJldmVydGluZyB0aGlzIGNoYW5n
ZSwgY2FuIHlvdSB0cnkgZm9sbG93aW5nIHBhdGNoID8KPj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlu
a3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yZS5rZXJuZWwu
b3JnJTJGbGludXgtcGNpJTJGNTZhZDQ5MDEtNzI1Zi03Yjg4LTIxMTctYjEyNGIyOGIwMjdmJTQw
bGludXguaW50ZWwuY29tJTJGVCUyRiUyM21lODAyOWMwNGY2M2MyMWY5ZDFjYjNiMWJhMmFlZmZi
Y2EzYTYwZGY1JmFtcDtkYXRhPTAyJTdDMDElN0NhbmRyZXkuZ3JvZHpvdnNreSU0MGFtZC5jb20l
N0M3NzMyNWQ2YTJhYmM0MmQyNmFlNjA4ZDg0ZjcyNmM1MSU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTEx
YTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2MzczNDY3MDAxNzA4MzE4NDYmYW1wO3NkYXRhPUpQbzhs
T1hmanhwcSUyQm5tbFZyU2k5M2FaeEdqSWxidWgwcmtabU5La3pRTSUzRCZhbXA7cmVzZXJ2ZWQ9
MCAKPj4KPj4KCi0tIApTYXRoeWFuYXJheWFuYW4gS3VwcHVzd2FteQpMaW51eCBLZXJuZWwgRGV2
ZWxvcGVyCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
