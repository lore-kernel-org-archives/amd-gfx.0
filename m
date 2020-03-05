Return-Path: <SRS0=Sanp=4W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7072C3F2D1
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:27:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6AE220801
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2020 11:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiufA60T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6AE220801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 780086E267;
	Thu,  5 Mar 2020 11:27:52 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23AF46E267
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2020 11:27:52 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id z15so6583918wrl.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2020 03:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=A1ZlNLc2/KkPExxyLXVJ4som48Fh41cSvDx5qHfjahQ=;
 b=EiufA60Tasg8QpBu686ZapV1TCxFadKzi5vR6ihPgDfz/5519M7MW016DrstnIzDIS
 DrRM6V0eQgxkWuwvuypTv5QdQ1+Fgu4EbWbavsjh6awY4rJUig6WUajV5SPH83KNeN7v
 o0AET0tFtzr2N5MQl6WBDzi+Wg8FCsRwB7Uw6DHHm15ozC6cgPzaVWGa/YMkg1jUrMjk
 zvo2xKU2r6fjNHboikv3SnoXqV1B8BJjqBCJ0EfyvJcLNYI6QBgwLl9kwXcQ6WM32n1k
 YU9RDWN7r8l+eFV7z0V7BQE8GBmaCp8E7zgKQMdtTAqTkj3lW+A+TeLfMx0Y7HcCzACc
 6WRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:from:to:cc:references
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=A1ZlNLc2/KkPExxyLXVJ4som48Fh41cSvDx5qHfjahQ=;
 b=Df1RdVkFnh1NGWu3HRYnzIQ1FaixKClWEocT7f2We93aCfMMEmV4MoqjbOWkYD7Imk
 1icmvN18wBzvKXMgYCOrjl0RnL9ndAWPsr1/MqnzkEQHxpv8WzwUZ6pEbAdchand49By
 e14AsnpkNw+hBTWwo5Fj9AQn+dlkVFiL1Zd2xiTU7nw0gXyq6QAtRYIJ58KJbjN6qpOY
 WjQ2TukgXYTHOjhBuxv+vQBoQzfifPqsx6jrHCeCL1I1mF8TqcjafefRRni/5fvXhnHv
 D6HqJdBVB92Op7cIuraIsIvhvQBvAZDkdk1Sx/yw6XAARXgsNsFVhMZRMXGgqN/aQY7h
 BBSA==
X-Gm-Message-State: ANhLgQ3jbH+rVv03enHcucg3s8xu5/rOUvUj0jtbTQ2ZatcrteUoSkCY
 hd4gem612xGo2RWhEOHcMzI=
X-Google-Smtp-Source: ADFU+vsQuUqU8OlrBacZgtV/YWSgftvvAYsRIBSBYnzKZp8GVcGmhOw2fOdyeKN4l/fKJ7iWtfVFkg==
X-Received: by 2002:a05:6000:10c5:: with SMTP id
 b5mr9944525wrx.203.1583407670831; 
 Thu, 05 Mar 2020 03:27:50 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id e8sm45330978wrr.69.2020.03.05.03.27.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Mar 2020 03:27:50 -0800 (PST)
Subject: Re: [PATCH v2 1/4] drm/amdgpu/vcn: fix race condition issue for vcn
 start
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1583259391-21834-1-git-send-email-James.Zhu@amd.com>
 <1583339699-11332-1-git-send-email-James.Zhu@amd.com>
 <9d50a60f-0b1d-ad1c-944c-7ff3a7b7cec5@gmail.com>
Message-ID: <590f2f72-808d-cf35-49ab-2ed476780db0@gmail.com>
Date: Thu, 5 Mar 2020 12:27:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9d50a60f-0b1d-ad1c-944c-7ff3a7b7cec5@gmail.com>
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
Reply-To: christian.koenig@amd.com
Cc: jamesz@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDUuMDMuMjAgdW0gMTI6MjUgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+IEFtIDA0LjAz
LjIwIHVtIDE3OjM0IHNjaHJpZWIgSmFtZXMgWmh1Ogo+PiBGaXggcmFjZSBjb25kaXRpb24gaXNz
dWUgd2hlbiBtdWx0aXBsZSB2Y24gc3RhcnRzIGFyZSBjYWxsZWQuCj4+Cj4+IHYyOiBSZW1vdmVk
IGNoZWNraW5nIHRoZSByZXR1cm4gdmFsdWUgb2YgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCkK
Pj4gdG8gcHJldmVudCBwb3NzaWJsZSByYWNlcyBoZXJlLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBK
YW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+Cj4gUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBL
w7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCk9uZSB0aGluZyB3b3J0aCBub3Rpbmcg
aXMgdGhhdCBpbiB0aGVvcnkgeW91IGNvdWxkIHJ1biBpbnRvIHRoZSBpc3N1ZSAKdGhhdCBvbmUg
cmluZyByZXN0YXJ0cyB0aGUgdGltZXIgd2hpbGUgYW5vdGhlciByaW5nIGlzIHN0aWxsIHByZXBh
cmluZyAKdGhlIGVuZ2luZSBmb3IgdXNhZ2UuCgpTbyB0aGUgdGltZW91dCBzaG91bGQgYmUgbGFy
Z2UgZW5vdWdoIHRvIGd1YXJhbnRlZSB0aGF0IHRoaXMgbmV2ZXIgCmNhdXNlcyBwcm9ibGVtcy4K
ClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uYyB8IDE1ICsrKysrKysrKy0tLS0tLQo+PiDCoCBkcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmggfMKgIDEgKwo+PiDCoCAyIGZpbGVzIGNoYW5n
ZWQsIDEwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMgCj4+IGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5jCj4+IGluZGV4IGY5NjQ2NGUuLjhhODQwNmIgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92Y24uYwo+PiAr
KysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdmNuLmMKPj4gQEAgLTYzLDYg
KzYzLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfaW5pdChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRl
dikKPj4gwqDCoMKgwqDCoCBpbnQgaSwgcjsKPj4gwqAgwqDCoMKgwqDCoCBJTklUX0RFTEFZRURf
V09SSygmYWRldi0+dmNuLmlkbGVfd29yaywgCj4+IGFtZGdwdV92Y25faWRsZV93b3JrX2hhbmRs
ZXIpOwo+PiArwqDCoMKgIG11dGV4X2luaXQoJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+IMKg
IMKgwqDCoMKgwqAgc3dpdGNoIChhZGV2LT5hc2ljX3R5cGUpIHsKPj4gwqDCoMKgwqDCoCBjYXNl
IENISVBfUkFWRU46Cj4+IEBAIC0yMTAsNiArMjExLDcgQEAgaW50IGFtZGdwdV92Y25fc3dfZmlu
aShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldikKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgIMKgwqDC
oMKgwqAgcmVsZWFzZV9maXJtd2FyZShhZGV2LT52Y24uZncpOwo+PiArwqDCoMKgIG11dGV4X2Rl
c3Ryb3koJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIDA7
Cj4+IMKgIH0KPj4gQEAgLTMxOSwxMyArMzIxLDEzIEBAIHN0YXRpYyB2b2lkIGFtZGdwdV92Y25f
aWRsZV93b3JrX2hhbmRsZXIoc3RydWN0IAo+PiB3b3JrX3N0cnVjdCAqd29yaykKPj4gwqAgdm9p
ZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRncHVfcmluZyAqcmluZykKPj4g
wqAgewo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gcmluZy0+YWRl
djsKPj4gLcKgwqDCoCBib29sIHNldF9jbG9ja3MgPSAhY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5j
KCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4gwqAgLcKgwqDCoCBpZiAoc2V0X2Nsb2Nrcykgewo+
PiAtwqDCoMKgwqDCoMKgwqAgYW1kZ3B1X2dmeF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+IC3C
oMKgwqDCoMKgwqDCoCBhbWRncHVfZGV2aWNlX2lwX3NldF9wb3dlcmdhdGluZ19zdGF0ZShhZGV2
LCAKPj4gQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBBTURfUEdfU1RBVEVfVU5HQVRFKTsKPj4gLcKgwqDCoCB9Cj4+ICvCoMKgwqAgY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93b3JrKTsKPj4gKwo+PiArwqDCoMKg
IG11dGV4X2xvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+ICvCoMKgwqAgYW1kZ3B1X2dm
eF9vZmZfY3RybChhZGV2LCBmYWxzZSk7Cj4+ICvCoMKgwqAgYW1kZ3B1X2RldmljZV9pcF9zZXRf
cG93ZXJnYXRpbmdfc3RhdGUoYWRldiwgQU1EX0lQX0JMT0NLX1RZUEVfVkNOLAo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqAgQU1EX1BHX1NUQVRFX1VOR0FURSk7Cj4+IMKgIMKgwqDCoMKgwqAgaWYg
KGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRynCoMKgwqAgewo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGRwZ19wYXVzZV9zdGF0ZSBuZXdfc3RhdGU7Cj4+IEBAIC0z
NDUsNiArMzQ3LDcgQEAgdm9pZCBhbWRncHVfdmNuX3JpbmdfYmVnaW5fdXNlKHN0cnVjdCBhbWRn
cHVfcmluZyAKPj4gKnJpbmcpCj4+IMKgIMKgwqDCoMKgwqDCoMKgwqDCoCBhZGV2LT52Y24ucGF1
c2VfZHBnX21vZGUoYWRldiwgcmluZy0+bWUsICZuZXdfc3RhdGUpOwo+PiDCoMKgwqDCoMKgIH0K
Pj4gK8KgwqDCoCBtdXRleF91bmxvY2soJmFkZXYtPnZjbi52Y25fcGdfbG9jayk7Cj4+IMKgIH0K
Pj4gwqAgwqAgdm9pZCBhbWRncHVfdmNuX3JpbmdfZW5kX3VzZShzdHJ1Y3QgYW1kZ3B1X3Jpbmcg
KnJpbmcpCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVf
dmNuLmggCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Zjbi5oCj4+IGlu
ZGV4IDZmZTA1NzMuLjJhZTExMGQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV92Y24uaAo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdmNuLmgKPj4gQEAgLTIwMCw2ICsyMDAsNyBAQCBzdHJ1Y3QgYW1kZ3B1X3ZjbiB7Cj4+
IMKgwqDCoMKgwqAgc3RydWN0IGRybV9ncHVfc2NoZWR1bGVyICp2Y25fZGVjX3NjaGVkW0FNREdQ
VV9NQVhfVkNOX0lOU1RBTkNFU107Cj4+IMKgwqDCoMKgwqAgdWludDMyX3TCoMKgwqDCoMKgwqDC
oMKgIG51bV92Y25fZW5jX3NjaGVkOwo+PiDCoMKgwqDCoMKgIHVpbnQzMl90wqDCoMKgwqDCoMKg
wqDCoCBudW1fdmNuX2RlY19zY2hlZDsKPj4gK8KgwqDCoCBzdHJ1Y3QgbXV0ZXjCoMKgwqDCoMKg
wqDCoMKgIHZjbl9wZ19sb2NrOwo+PiDCoCDCoMKgwqDCoMKgIHVuc2lnbmVkwqDCoMKgIGhhcnZl
c3RfY29uZmlnOwo+PiDCoMKgwqDCoMKgIGludCAoKnBhdXNlX2RwZ19tb2RlKShzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiwKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQt
Z2Z4Cg==
