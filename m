Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C18C433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA4A613B6
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 07:10:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA4A613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E78996E1AA;
	Tue, 13 Apr 2021 07:10:31 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586326E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 07:10:31 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id w3so24259480ejc.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=QcHX7QgDI6ldxvc81HBUMeyGPvBxKVsz0YnD0Fsw0t4=;
 b=tASjsTSdINDMJjcvIVWN0/AT6b8PnCZ0cxHUjO6obbmACGMOYHQz2FpPqkU1z8QJhW
 btiucO+q4xkKn7doQdopsnSNerMsMMTYczXtZDTsRrS02bwS8O2QKAl2gLfmSByat/vR
 uppKnBiNOhWEd8kgx7TSr+3/X4lwEeZObFVv0aidaIEMzRIQlwG1U4IHbBo4tEOp8Uzj
 XUz+o5YX5KLGJqzAr6iTIYY/NIUW/NX+qSUOtYxNfB+ViqMVj3pRD0AElJg6VxDyn0qL
 gMGQkHouw42OGWGPQQxjsiMlOiq7IigdWfPuC8Hxvdxv/BnC5kqmwZAQcHdlilcwU/VF
 lPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=QcHX7QgDI6ldxvc81HBUMeyGPvBxKVsz0YnD0Fsw0t4=;
 b=GvPPIFynjaKXI1DZC+wVLX3suW7hgJzJl7MNzF+12u8wpHjILaeAnzlkIYl7vNu401
 jfAHEV4+1O+jpk7sr2FvC8v8OrTvM27HzHQuWxKYmfploPFoEqX/fd+e5/oXNITiE4na
 WcY/ONcq/Zr2eP7e+Hmexrlhm6hh4Svv7eJeHGDbtcwxhkNx5izMwjdgMTB/tB5HOGK8
 W2PR95hhmvjB1UMuTHsQ4BBs0w8c1IVxO6nDb2+tPB99hcOzjQvPzYtJtI9XiU1vvHoF
 BPH0TiaQ8yOp6leoSezvIbTM16LPP/4JHX3GLHhntUtITHlcryYK4uIIGdwQGNARo6T8
 3M2w==
X-Gm-Message-State: AOAM531g5uHv8SHZJVXONCfEEQKXb+FrtEa9giVCvo9pBhCkY6Ecvwmq
 dT60GGMPXJrP7qbpmSiVk70=
X-Google-Smtp-Source: ABdhPJygVI1x9jFhaITxnuQRQzKGZKANuD9ACgpsQgN1aEGO4UGk6Xj5oULQkixgSMMKPCfRYqHKIg==
X-Received: by 2002:a17:906:11ce:: with SMTP id
 o14mr9751421eja.113.1618297829991; 
 Tue, 13 Apr 2021 00:10:29 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:acbc:5f44:93b6:4587?
 ([2a02:908:1252:fb60:acbc:5f44:93b6:4587])
 by smtp.gmail.com with ESMTPSA id li16sm4438699ejb.101.2021.04.13.00.10.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 00:10:29 -0700 (PDT)
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
 <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
Date: Tue, 13 Apr 2021 09:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMTIuMDQuMjEgdW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMTIgMzoxOCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAxMi4wNC4y
MSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4gW1NOSVBdCj4+Pj4+Cj4+
Pj4+IFNvIHdoYXQncyB0aGUgcmlnaHQgYXBwcm9hY2ggPyBIb3cgd2UgZ3VhcmFudGVlIHRoYXQg
d2hlbiBydW5uaW5nIAo+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24g
d2Ugd2lsbCBzaWduYWwgYWxsIHRoZSBIVyAKPj4+Pj4gZmVuY2VzIGFuZCBub3QgcmFjaW5nIGFn
YWluc3Qgc29tZSBtb3JlIGZlbmNlcyBpbnNlcnRpb24gaW50byB0aGF0IAo+Pj4+PiBhcnJheSA/
Cj4+Pj4+Cj4+Pj4KPj4+PiBXZWxsIEkgd291bGQgc3RpbGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNo
IHdvdWxkIGJlIHRvIGluc2VydCB0aGlzIAo+Pj4+IGJldHdlZW4gdGhlIGZyb250IGVuZCBhbmQg
dGhlIGJhY2tlbmQgYW5kIG5vdCByZWx5IG9uIHNpZ25hbGluZyAKPj4+PiBmZW5jZXMgd2hpbGUg
aG9sZGluZyB0aGUgZGV2aWNlIHNyY3UuCj4+Pgo+Pj4KPj4+IE15IHF1ZXN0aW9uIGlzLCBldmVu
IG5vdywgd2hlbiB3ZSBydW4gCj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdw
dV9mZW5jZV93YWl0X2VtcHR5IG9yIAo+Pj4gYW1kZ3B1X2ZlbmNlX2RyaXZlcl9maW5pX2h3LT5h
bWRncHVfZmVuY2VfZHJpdmVyX2ZvcmNlX2NvbXBsZXRpb24sIAo+Pj4gd2hhdCB0aGVyZSBwcmV2
ZW50cyBhIHJhY2Ugd2l0aCBhbm90aGVyIGZlbmNlIGJlaW5nIGF0IHRoZSBzYW1lIHRpbWUgCj4+
PiBlbWl0dGVkIGFuZCBpbnNlcnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tzIGxpa2Ug
bm90aGluZy4KPj4+Cj4+Cj4+IEVhY2ggcmluZyBjYW4gb25seSBiZSB1c2VkIGJ5IG9uZSB0aHJl
YWQgYXQgdGhlIHNhbWUgdGltZSwgdGhpcyAKPj4gaW5jbHVkZXMgZW1pdHRpbmcgZmVuY2VzIGFz
IHdlbGwgYXMgb3RoZXIgc3R1ZmYuCj4+Cj4+IER1cmluZyBHUFUgcmVzZXQgd2UgbWFrZSBzdXJl
IG5vYm9keSB3cml0ZXMgdG8gdGhlIHJpbmdzIGJ5IHN0b3BwaW5nIAo+PiB0aGUgc2NoZWR1bGVy
IGFuZCB0YWtpbmcgdGhlIEdQVSByZXNldCBsb2NrIChzbyB0aGF0IG5vYm9keSBlbHNlIGNhbiAK
Pj4gc3RhcnQgdGhlIHNjaGVkdWxlciBhZ2FpbikuCj4KPgo+IFdoYXQgYWJvdXQgZGlyZWN0IHN1
Ym1pc3Npb25zIG5vdCB0aHJvdWdoIHNjaGVkdWxlciAtIAo+IGFtZGdwdV9qb2Jfc3VibWl0X2Rp
cmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgcHJvdGVjdGVkLgoKVGhvc2Ugb25seSBoYXBw
ZW4gZHVyaW5nIHN0YXJ0dXAgYW5kIEdQVSByZXNldC4KCj4+Cj4+Pj4KPj4+PiBCVFc6IENvdWxk
IGl0IGJlIHRoYXQgdGhlIGRldmljZSBTUkNVIHByb3RlY3RzIG1vcmUgdGhhbiBvbmUgZGV2aWNl
IAo+Pj4+IGFuZCB3ZSBkZWFkbG9jayBiZWNhdXNlIG9mIHRoaXM/Cj4+Pgo+Pj4KPj4+IEkgaGF2
ZW4ndCBhY3R1YWxseSBleHBlcmllbmNlZCBhbnkgZGVhZGxvY2sgdW50aWwgbm93IGJ1dCwgeWVz
LCAKPj4+IGRybV91bnBsdWdfc3JjdSBpcyBkZWZpbmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMg
YW5kIHNvIGluIHRoZSAKPj4+IHByZXNlbmNlwqAgb2YgbXVsdGlwbGUgZGV2aWNlcyBmcm9tIHNh
bWUgb3IgZGlmZmVyZW50IGRyaXZlcnMgd2UgaW4gCj4+PiBmYWN0IGFyZSBkZXBlbmRlbnQgb24g
YWxsIHRoZWlyIGNyaXRpY2FsIHNlY3Rpb25zIGkgZ3Vlc3MuCj4+Pgo+Pgo+PiBTaGl0LCB5ZWFo
IHRoZSBkZXZpbCBpcyBhIHNxdWlycmVsLiBTbyBmb3IgQStJIGxhcHRvcHMgd2UgYWN0dWFsbHkg
Cj4+IG5lZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBvZiB0aGUg
aTkxNSBndXlzLgo+Pgo+PiBJSVJDIHdlIGNvdWxkIGFjdHVhbGx5IGhhdmUgYW4gYW1kZ3B1IGRl
dmljZSBpbiBhIGRvY2tpbmcgc3RhdGlvbiAKPj4gd2hpY2ggbmVlZHMgaG90cGx1ZyBhbmQgdGhl
IGRyaXZlciBtaWdodCBkZXBlbmQgb24gd2FpdGluZyBmb3IgdGhlIAo+PiBpOTE1IGRyaXZlciBh
cyB3ZWxsLgo+Cj4KPiBDYW4ndCB3ZSBwcm9wb3NlIGEgcGF0Y2ggdG8gbWFrZSBkcm1fdW5wbHVn
X3NyY3UgcGVyIGRybV9kZXZpY2UgPyBJIAo+IGRvbid0IHNlZSB3aHkgaXQgaGFzIHRvIGJlIGds
b2JhbCBhbmQgbm90IHBlciBkZXZpY2UgdGhpbmcuCgpJJ20gcmVhbGx5IHdvbmRlcmluZyB0aGUg
c2FtZSB0aGluZyBmb3IgcXVpdGUgYSB3aGlsZSBub3cuCgpBZGRpbmcgRGFuaWVsIGFzIHdlbGws
IG1heWJlIGhlIGtub3dzIHdoeSB0aGUgZHJtX3VucGx1Z19zcmN1IGlzIGdsb2JhbC4KClJlZ2Fy
ZHMsCkNocmlzdGlhbi4KCj4KPiBBbmRyZXkKPgo+Cj4+Cj4+IENocmlzdGlhbi4KPj4KPj4+IEFu
ZHJleQo+Pj4KPj4+Cj4+Pj4KPj4+PiBDaHJpc3RpYW4uCj4+Pj4KPj4+Pj4gQW5kcmV5Cj4+Pj4+
Cj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+
Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gwqDCoMKgIC8qIFBhc3QgdGhpcyBw
b2ludCBubyBtb3JlIGZlbmNlIGFyZSBzdWJtaXR0ZWQgdG8gSFcgcmluZyAKPj4+Pj4+Pj4+IGFu
ZCBoZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9yY2Ugc2lnbmFsIG9uIGFsbCB0aGF0IGFyZSAK
Pj4+Pj4+Pj4+IGN1cnJlbnRseSB0aGVyZS4KPj4+Pj4+Pj4+IMKgwqDCoMKgICogQW55IHN1YnNl
cXVlbnRseSBjcmVhdGVkwqAgSFcgZmVuY2VzIHdpbGwgYmUgcmV0dXJuZWQgCj4+Pj4+Pj4+PiBz
aWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUgcmlnaHQgYXdheQo+Pj4+Pj4+Pj4gwqDCoMKgwqAg
Ki8KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiDCoMKgwqAgZm9yX2VhY2hfcmluZyhhZGV2KQo+Pj4+Pj4+
Pj4gwqDCoMKgIMKgwqDCoCBhbWRncHVfZmVuY2VfcHJvY2VzcyhyaW5nKQo+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+IMKgwqDCoCBkcm1fZGV2X3VucGx1ZyhkZXYpOwo+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Ag
c2NoZWR1bGVycwo+Pj4+Pj4+Pj4gwqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1
ZXVlZCB3b3Jrcyk7Cj4+Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4gwqDCoMKgIHVu
bWFwX21taW8KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2ZWx5IGdyYWJi
aW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIGFuZCBzdG9wcGluZyAKPj4+Pj4+Pj4+Pj4+Pj4gYW5k
IHRoZW4gcmVzdGFydGluZyB0aGUgc2NoZWR1bGVyIGNvdWxkIHdvcmsgYXMgd2VsbC4KPj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+PiBJIGRpZG4ndCBnZXQgdGhlIGFib3ZlIGFuZCBJIGRvbid0IHNl
ZSB3aHkgSSBuZWVkIHRvIHJldXNlIAo+Pj4+Pj4+Pj4+Pj4+IHRoZSBHUFUgcmVzZXQgcndfbG9j
ay4gSSByZWx5IG9uIHRoZSBTUkNVIHVucGx1ZyBmbGFnIGZvciAKPj4+Pj4+Pj4+Pj4+PiB1bnBs
dWcuIEFsc28sIG5vdCBjbGVhciB0byBtZSB3aHkgYXJlIHdlIGZvY3VzaW5nIG9uIHRoZSAKPj4+
Pj4+Pj4+Pj4+PiBzY2hlZHVsZXIgdGhyZWFkcywgYW55IGNvZGUgcGF0Y2ggdG8gZ2VuZXJhdGUg
SFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4+IHNob3VsZCBiZSBjb3ZlcmVkLCBzbyBhbnkgY29kZSBs
ZWFkaW5nIHRvIAo+Pj4+Pj4+Pj4+Pj4+IGFtZGdwdV9mZW5jZV9lbWl0IG5lZWRzIHRvIGJlIHRh
a2VuIGludG8gYWNjb3VudCBzdWNoIGFzLCAKPj4+Pj4+Pj4+Pj4+PiBkaXJlY3QgSUIgc3VibWlz
c2lvbnMsIFZNIGZsdXNoZXMgZS50LmMKPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBZb3UgbmVl
ZCB0byB3b3JrIHRvZ2V0aGVyIHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCBjYXVzZSAKPj4+
Pj4+Pj4+Pj4+IGEgaG90cGx1ZyBjb3VsZCBydW4gYXQgdGhlIHNhbWUgdGltZSBhcyBhIHJlc2V0
Lgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5IGlu
ZGVlZCBub3cgSSBzZWUgbm93IHRoYXQgSSBoYXZlIHRvIHRha2UgCj4+Pj4+Pj4+Pj4+IHJlc2V0
IHdyaXRlIHNpZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIHNpZ25hbGxpbmcgaW4gb3JkZXIgCj4+
Pj4+Pj4+Pj4+IHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVsZXIvSFcgZmVuY2VzIGRldGFjaG1l
bnQgYW5kIAo+Pj4+Pj4+Pj4+PiByZWF0dGFjaG1lbnQgZHVyaW5nIHNjaGVkdWxlcnMgc3RvcC9y
ZXN0YXJ0LiBCdXQgaWYgd2UgZ28gCj4+Pj4+Pj4+Pj4+IHdpdGggeW91ciBhcHByb2FjaMKgIHRo
ZW4gY2FsbGluZyBkcm1fZGV2X3VucGx1ZyBhbmQgc2NvcGluZyAKPj4+Pj4+Pj4+Pj4gYW1kZ3B1
X2pvYl90aW1lb3V0IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggCj4+
Pj4+Pj4+Pj4+IHRvIHByZXZlbnQgYW55IGNvbmN1cnJlbnQgR1BVIHJlc2V0cyBkdXJpbmcgdW5w
bHVnLiBJbiBmYWN0IAo+Pj4+Pj4+Pj4+PiBJIGFscmVhZHkgZG8gaXQgYW55d2F5IC0gCj4+Pj4+
Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxpbnV4JTJG
Y29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0ZDI2NDlj
NWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5ncm9kem92c2t5
JTQwYW1kLmNvbSU3Q2VlZmE5YzkwZWQ4YzQwNWVjM2I3MDhkOGZjNDZkYWFhJTdDM2RkODk2MWZl
NDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzNjcyODU1MDg4NDc0MCU3Q1Vu
a25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlM
Q0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1VaU5hSkUlMkJI
NDVpWW1id1NEbk1TS1pTNXowaWFrMGZObGJiZllxS1MySm8lM0QmYW1wO3Jlc2VydmVkPTAKPj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFllcywgZ29vZCBwb2ludCBhcyB3ZWxsLgo+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+IEFu
ZHJleQo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBB
bmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4KPj4+Pj4+Cj4+Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
