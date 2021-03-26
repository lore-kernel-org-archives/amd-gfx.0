Return-Path: <SRS0=Uu1B=IY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54A4C433E2
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A27B61A13
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Mar 2021 13:30:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A27B61A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=126.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04FE6F3D5;
	Fri, 26 Mar 2021 13:30:39 +0000 (UTC)
Received: from m15114.mail.126.com (m15114.mail.126.com [220.181.15.114])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C8616E0FC;
 Fri, 26 Mar 2021 09:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Subject:From:Message-ID:Date:MIME-Version; bh=HO2+8
 yOEkgeYzysiOq9FR+H9/COuTtLqX7AQLkhjh0E=; b=nK+Ik7kcibyjN8ExUMi/4
 WYjcmHp38Co+WDcoInpxrviF9oui2r6CTEZMYMuO1PcwN746RU2QoC6tzUFRQW3x
 iRa6d0qqx/ewMyr7gS0WI5xRM3CiWGFRMytnurrL17n9sb9ngF5hiBsoisyIwR1E
 okc0Hq8aeIXnEC5PLvDduc=
Received: from [172.20.20.87] (unknown [182.150.46.145])
 by smtp7 (Coremail) with SMTP id DsmowACnkVGCq11gfdmvPA--.60080S2;
 Fri, 26 Mar 2021 17:38:12 +0800 (CST)
Subject: Re: [PATCH] drm/amdkfd: dqm fence memory corruption
To: Felix Kuehling <felix.kuehling@amd.com>
References: <1611750806-10730-1-git-send-email-jinsdb@126.com>
 <4de809ac-fdd7-b02a-c55f-3c79321cfb7f@amd.com>
From: Qu Huang <jinsdb@126.com>
Message-ID: <14c4be41-28ab-3266-eaf3-b6b0342e18ba@126.com>
Date: Fri, 26 Mar 2021 17:38:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4de809ac-fdd7-b02a-c55f-3c79321cfb7f@amd.com>
X-CM-TRANSID: DsmowACnkVGCq11gfdmvPA--.60080S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tFW7XFyrAw15Gw48Wry7GFg_yoW8Aw4fpF
 WkJFy5Kry8Jw12v34xXa18uFy5Cw4rWrWfWFy7C39xua13XF9IyrW5AFWUK348uFyvya17
 tF4DCrZruF1qvaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jQ189UUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: pmlq2vbe6rjloofrz/1tbigQRhDlpECnN1nQAAsl
X-Mailman-Approved-At: Fri, 26 Mar 2021 13:30:38 +0000
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
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 daniel@ffwll.ch, alexander.deucher@amd.com, christian.koenig@amd.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gMjAyMS8xLzI4IDU6NTAsIEZlbGl4IEt1ZWhsaW5nIHdyb3RlOgo+IEFtIDIwMjEtMDEtMjcg
dW0gNzozMyBhLm0uIHNjaHJpZWIgUXUgSHVhbmc6Cj4+IEFtZGdwdSBkcml2ZXIgdXNlcyA0LWJ5
dGUgZGF0YSB0eXBlIGFzIERRTSBmZW5jZSBtZW1vcnksCj4+IGFuZCB0cmFuc21pdHMgR1BVIGFk
ZHJlc3Mgb2YgZmVuY2UgbWVtb3J5IHRvIG1pY3JvY29kZQo+PiB0aHJvdWdoIHF1ZXJ5IHN0YXR1
cyBQTTQgbWVzc2FnZS4gSG93ZXZlciwgcXVlcnkgc3RhdHVzCj4+IFBNNCBtZXNzYWdlIGRlZmlu
aXRpb24gYW5kIG1pY3JvY29kZSBwcm9jZXNzaW5nIGFyZSBhbGwKPj4gcHJvY2Vzc2VkIGFjY29y
ZGluZyB0byA4IGJ5dGVzLiBGZW5jZSBtZW1vcnkgb25seSBhbGxvY2F0ZXMKPj4gNCBieXRlcyBv
ZiBtZW1vcnksIGJ1dCBtaWNyb2NvZGUgZG9lcyB3cml0ZSA4IGJ5dGVzIG9mIG1lbW9yeSwKPj4g
c28gdGhlcmUgaXMgYSBtZW1vcnkgY29ycnVwdGlvbi4KPiAKPiBUaGFuayB5b3UgZm9yIHBvaW50
aW5nIG91dCB0aGF0IGRpc2NyZXBhbmN5LiBUaGF0J3MgYSBnb29kIGNhdGNoIQo+IAo+IEknZCBw
cmVmZXIgdG8gZml4IHRoaXMgcHJvcGVybHkgYnkgbWFraW5nIGRxbS0+ZmVuY2VfYWRkciBhIHU2
NCBwb2ludGVyLgo+IFdlIHNob3VsZCBwcm9iYWJseSBhbHNvIGZpeCB1cCB0aGUgcXVlcnlfc3Rh
dHVzIGFuZAo+IGFtZGtmZF9mZW5jZV93YWl0X3RpbWVvdXQgZnVuY3Rpb24gaW50ZXJmYWNlcyB0
byB1c2UgYSA2NCBiaXQgZmVuY2UKPiB2YWx1ZXMgZXZlcnl3aGVyZSB0byBiZSBjb25zaXN0ZW50
Lgo+IAo+IFJlZ2FyZHMsCj4gIMKgIEZlbGl4CkhpIEZlbGl4LCBUaGFua3MgZm9yIHlvdXIgYWR2
aWNlLCBwbGVhc2UgY2hlY2sgdjIgYXQgCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29y
ay9wYXRjaC8xMzcyNTg0LwpUaGFua3MsClF1Lgo+IAo+IAo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBR
dSBIdWFuZyA8amluc2RiQDEyNi5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQv
YW1ka2ZkL2tmZF9kZXZpY2VfcXVldWVfbWFuYWdlci5jIHwgMiArLQo+PiAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRrZmQva2ZkX2RldmljZV9xdWV1ZV9tYW5hZ2VyLmMgYi9kcml2
ZXJzL2dwdS9kcm0vYW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+PiBpbmRl
eCBlNjg2Y2UyLi44YjM4ZDBjIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGtmZC9rZmRfZGV2aWNlX3F1ZXVlX21hbmFnZXIuYwo+PiBAQCAtMTE2MSw3ICsxMTYx
LDcgQEAgc3RhdGljIGludCBzdGFydF9jcHNjaChzdHJ1Y3QgZGV2aWNlX3F1ZXVlX21hbmFnZXIg
KmRxbSkKPj4gICAJcHJfZGVidWcoIkFsbG9jYXRpbmcgZmVuY2UgbWVtb3J5XG4iKTsKPj4gICAK
Pj4gICAJLyogYWxsb2NhdGUgZmVuY2UgbWVtb3J5IG9uIHRoZSBnYXJ0ICovCj4+IC0JcmV0dmFs
ID0ga2ZkX2d0dF9zYV9hbGxvY2F0ZShkcW0tPmRldiwgc2l6ZW9mKCpkcW0tPmZlbmNlX2FkZHIp
LAo+PiArCXJldHZhbCA9IGtmZF9ndHRfc2FfYWxsb2NhdGUoZHFtLT5kZXYsIHNpemVvZih1aW50
NjRfdCksCj4+ICAgCQkJCQkmZHFtLT5mZW5jZV9tZW0pOwo+PiAgIAo+PiAgIAlpZiAocmV0dmFs
KQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdm
eCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
