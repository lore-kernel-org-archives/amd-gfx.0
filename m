Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61928C433E0
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 07:37:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C8A2073A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 07:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C8A2073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8DA6E098;
	Mon, 10 Aug 2020 07:36:10 +0000 (UTC)
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTP id 751B46E115
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 00:58:22 +0000 (UTC)
Received: from [10.130.0.75] (unknown [113.200.148.30])
 by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxmMWlmzBfhZcGAA--.2846S3;
 Mon, 10 Aug 2020 08:58:14 +0800 (CST)
Subject: Re: [PATCH] gpu/drm: Remove TTM_PL_FLAG_WC of VRAM to fix
 writecombine issue for Loongson64
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <1596871502-3432-1-git-send-email-yangtiezhu@loongson.cn>
 <20200808134147.GA5772@alpha.franken.de>
 <b7b16df1-d661-d59a-005b-da594ce9fc95@flygoat.com>
 <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <fb68c6ee-d455-24a0-524e-9b8a5033becd@loongson.cn>
Date: Mon, 10 Aug 2020 08:58:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <38857c24-25c4-cff3-569e-5bcb773bfae6@amd.com>
X-CM-TRANSID: AQAAf9DxmMWlmzBfhZcGAA--.2846S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyUur48Zw1DtrWrJw4DXFb_yoW8tF4kpF
 ZxKa1SgF4DJr4jyFnFqwn3XrWjkws5trW7Krn5CrWDu3sxtrnYgFyxKFWqvFWDur1fX3Wj
 vF47WFyrua4ruFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
 02Avz4vE14v_twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
 02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
 GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
 CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
 wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
 xUcPfHUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Mailman-Approved-At: Mon, 10 Aug 2020 07:36:09 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huacai Chen <chenhc@lemote.com>,
 linux-mips@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMDgvMDkvMjAyMCAwODoxMyBQTSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAwOC4w
OC4yMCB1bSAxNTo1MCBzY2hyaWViIEppYXh1biBZYW5nOgo+Pgo+Pgo+PiDlnKggMjAyMC84Lzgg
5LiL5Y2IOTo0MSwgVGhvbWFzIEJvZ2VuZG9lcmZlciDlhpnpgZM6Cj4+PiBPbiBTYXQsIEF1ZyAw
OCwgMjAyMCBhdCAwMzoyNTowMlBNICswODAwLCBUaWV6aHUgWWFuZyB3cm90ZToKPj4+PiBMb29u
Z3NvbiBwcm9jZXNzb3JzIGhhdmUgYSB3cml0ZWNvbWJpbmUgaXNzdWUgdGhhdCBtYXliZSBmYWls
ZWQgdG8KPj4+PiB3cml0ZSBiYWNrIGZyYW1lYnVmZmVyIHVzZWQgd2l0aCBBVEkgUmFkZW9uIG9y
IEFNRCBHUFUgYXQgdGltZXMsCj4+Pj4gYWZ0ZXIgY29tbWl0IDhhMDhlNTBjZWU2NiAoImRybTog
UGVybWl0IHZpZGVvLWJ1ZmZlcnMgd3JpdGVjb21iaW5lCj4+Pj4gbWFwcGluZyBmb3IgTUlQUyIp
LCB0aGVyZSBleGlzdHMgc29tZSBlcnJvcnMgc3VjaCBhcyBibHVycmVkIHNjcmVlbgo+Pj4+IGFu
ZCBsb2NrdXAsIGFuZCBzbyBvbi4KPj4+Pgo+Pj4+IFJlbW92ZSB0aGUgZmxhZyBUVE1fUExfRkxB
R19XQyBvZiBWUkFNIHRvIGZpeCB3cml0ZWNvbWJpbmUgaXNzdWUgZm9yCj4+Pj4gTG9vbmdzb242
NCB0byB3b3JrIHdlbGwgd2l0aCBBVEkgUmFkZW9uIG9yIEFNRCBHUFUsIGFuZCBpdCBoYXMgbm8g
YW55Cj4+Pj4gaW5mbHVlbmNlIG9uIHRoZSBvdGhlciBwbGF0Zm9ybXMuCj4+PiB3ZWxsIGl0J3Mg
bm90IG15IGNhbGwgdG8gdGFrZSBvciByZWplY3QgdGhpcyBwYXRjaCwgYnV0IEkgYWxyZWFkeQo+
Pj4gaW5kaWNhdGVkIGl0IG1pZ2h0IGJlIGJldHRlciB0byBkaXNhYmxlIHdyaXRlY29tYmluZSBv
biB0aGUgQ1BVCj4+PiBkZXRlY3Rpb24gc2lkZSAob3IgZG8geW91IGhhdmUgb3RoZXIgZGV2aWNl
cyB3aGVyZSB3cml0ZWNvbWJpbmluZwo+Pj4gd29ya3MgPykuIFNvbWV0aGluZyBsaWtlIGJlbG93
IHdpbGwgZGlzYmFsZSBpdCBmb3IgYWxsIGxvb25nc29uNjQgQ1BVcy4KPj4+IElmIHlvdSBub3cg
ZmluZCBvdXQgd2hlcmUgaXQgd29ya3MgYW5kIHdoZXJlIGl0IGRvZXNuJ3QsIHlvdSBjYW4gZXZl
bgo+Pj4gcmVkdWNlIGl0IHRvIHRoZSByZXF1aXJlZCBtaW5pdW0gb2YgYWZmZWN0ZWQgQ1BVcy4K
Pj4gSGkgVGllemh1LCBUaG9tYXMsCj4+Cj4+IFllcywgd3JpdGVjb21iaW5lIHdvcmtzIHdlbGwg
b24gTFM3QSdzIGludGVybmFsIEdQVS4uLi4KPj4gQW5kIGV2ZW4gd29ya3Mgd2VsbCB3aXRoIHNv
bWUgQU1EIEdQVXMgKGluIG15IGNhc2UsIFJYNTUwKS4KPgo+IEluIHRoaXMgY2FzZSB0aGUgcGF0
Y2ggaXMgYSBjbGVhciBOQUsgc2luY2UgeW91IGhhdmVuJ3Qgcm9vdCBjYXVzZWQgCj4gdGhlIGlz
c3VlIGFuZCBhcmUganVzdCB3b3JraW5nIGFyb3VuZCBpdCBpbiBhIHZlcnkgcXVlc3Rpb25hYmxl
IG1hbm5lci4KPgo+Pgo+PiBUaWV6aHUsIGlzIGl0IHBvc3NpYmxlIHRvIGludmVzdGlnYXRlIHRo
ZSBpc3N1ZSBkZWVwZXIgaW4gTG9vbmdzb24/Cj4+IFByb2JhYmx5IHdlIGp1c3QgbmVlZCB0byBh
ZGQgc29tZSBiYXJyaWVyIHRvIG1haW50YWluIHRoZSBkYXRhIAo+PiBjb2hlcmVuY3ksCj4+IG9y
IGRpc2FibGUgd3JpdGVjb21iaW5lIGZvciBBTUQgR1BVJ3MgY29tbWFuZCBidWZmZXIgYW5kIGxl
YXZlIAo+PiB0ZXh0dXJlL2ZyYW1lCj4+IGJ1ZmZlciB3YyBhY2NlbGVyYXRlZC4KPgo+IEhhdmUg
eW91IG1vdmVkIGFueSBidWZmZXIgdG8gVlJBTSBhbmQgZm9yZ290IHRvIGFkZCBhbiBIRFAgCj4g
Zmx1c2gvaW52YWxpZGF0ZT8KPgo+IFRoZSBhY2NlbGVyYXRpb24gaXMgbm90IG11Y2ggb2YgYSBw
cm9ibGVtLCBidXQgaWYgV0MgZG9lc24ndCB3b3JrIGluIAo+IGdlbmVyYWwgeW91IG5lZWQgdG8g
ZGlzYWJsZSBpdCBmb3IgdGhlIHdob2xlIENQVSBhbmQgbm90IGZvciAKPiBpbmRpdmlkdWFsIGRy
aXZlcnMuCgpIaSBUaG9tYXMsIEppYXh1biBhbmQgQ2hyaXN0aWFuLAoKVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgeW91ciBzdWdnZXN0aW9ucy4KCkFjdHVhbGx5LCB0aGlzIHBhdGNoIGlzIGEgdGVt
cG9yYXJ5IHNvbHV0aW9uIHRvIGp1c3QgbWFrZSBpdCB3b3JrIHdlbGwsCml0IGlzIG5vdCBhIHBy
b3BlciBhbmQgZmluYWwgc29sdXRpb24uCgpJIHVuZGVyc3RhbmQgeW91ciBvcGluaW9ucywgaXQg
d2lsbCB0YWtlIHNvbWUgdGltZSB0byBmaW5kIHRoZSByb290IGNhdXNlLgoKVGhhbmtzLApUaWV6
aHUKCj4KPiBSZWdhcmRzLAo+IENocmlzdGlhbi4KPgo+Pgo+PiBUaGFua3MuCj4+Cj4+IC0gSmlh
eHVuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQt
Z2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xp
c3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
