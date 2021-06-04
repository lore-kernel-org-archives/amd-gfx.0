Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67674C07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23641613FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 13:46:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23641613FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43036E4E3;
	Fri,  4 Jun 2021 13:46:18 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A6836E4E3
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 13:46:17 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id g18so9213342edq.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Jun 2021 06:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=G29swBH/9UDHyOjYUZ9BkBkY9QUsmJTV4hpNNFVUIAg=;
 b=hfFpW5SaXAgk+An9bcXjrM3qarUsSMQzjW8+kIGoW2nUTM3wThUCmWsQLC2yTAr/hB
 xrMf/SC3orpEIL9QSt8xIWEWBPiQTgTBphQ8fguAOq7e1jp95Mqu3+8x81e6jvfXyBMd
 TABrPLfJFJIG7T4pr5XBJfuDGHJ8g9enAzRUk6ox9w1TBsR4MKG93FeW9cZWCxWdx4Ku
 0OO/8lQ0H3inpR+QTVp+N/Kvy8/b4aQVPUHywB7JPWoyCMQ5zgvcx0/2GbAG+MQ45vHH
 oSmLVsO3YPhYZdZ1Pl726dJ7Z+aONYh28mS6aR7sMuShG/n6QqjnfeozK7WcgpwXU8cw
 700Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=G29swBH/9UDHyOjYUZ9BkBkY9QUsmJTV4hpNNFVUIAg=;
 b=Bx9IPlw7dT9zYPaADVhim+4kAoBT+jy0d+u5+c7n1GkdfxQjhVG/5BloB/es77Nma9
 X8O4DgoGnLPJlbAPrrIViIoTISh+ttphhR4SS8+T4tGb2QlBX6NK9pMuZVHwC0F64tmV
 lo4DMpX8hs0ruQMLbD4ZM3QN0sjgskK/1EfUQiCACppzciN2sukutBNWJubFyuMsZEOy
 49QvIrnfu5kzljoQN7Sla7GCjy52At61QGxlPdCwwnE2uOXXS1jrYgqWCI4p/4TE4pvX
 6huIlQiSMuzH/rE/xBTw9WFsHpbNhN53MTC4eP+TTcPrfDK8kXUuQmq6zziOl/qJVTl9
 7T4A==
X-Gm-Message-State: AOAM530Vr38g8coAo+TL4n1asSqG7k9AdxhPZb3y+3RABbMe4rusXshd
 JLlAFzg8H2NhfgwckIsZBj3TBG30OFU=
X-Google-Smtp-Source: ABdhPJw3QOFQ4nesHfxhgPp7RMmSN2ZSVqgokQKFZgjmlntP5UR23SH/4ytwrYMB3jqV+wr1LEKfdw==
X-Received: by 2002:a50:fe81:: with SMTP id d1mr4793936edt.219.1622814376011; 
 Fri, 04 Jun 2021 06:46:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7b4b:873a:17b5:b581?
 ([2a02:908:1252:fb60:7b4b:873a:17b5:b581])
 by smtp.gmail.com with ESMTPSA id b14sm3315169edz.21.2021.06.04.06.46.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jun 2021 06:46:15 -0700 (PDT)
Subject: Re: [PATCH 1/5] drm/amdgpu: remove sriov vf checking from getting fb
 location
To: "Luo, Zhigang" <Zhigang.Luo@amd.com>, "Deng, Emily" <Emily.Deng@amd.com>, 
 "Liu, Shaoyun" <Shaoyun.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210603141305.2542-1-zhigang.luo@amd.com>
 <DM6PR12MB5534D815A3DBF82EBE78C576F43C9@DM6PR12MB5534.namprd12.prod.outlook.com>
 <PH0PR12MB54171568B27151FC487210928F3B9@PH0PR12MB5417.namprd12.prod.outlook.com>
 <befc7f07-613a-d1bd-434a-516035552a79@gmail.com>
 <BL1PR12MB531733CB397DBB9AF12C13FBF13B9@BL1PR12MB5317.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0126c234-be22-f615-d9ad-c671e615cb37@gmail.com>
Date: Fri, 4 Jun 2021 15:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BL1PR12MB531733CB397DBB9AF12C13FBF13B9@BL1PR12MB5317.namprd12.prod.outlook.com>
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

V2VsbCwgYnV0IGFyZSB5b3UgdGhlIG9uZSBkZWZpbmluZyB0aGUgY29tcGF0aWJpbGl0eSBwb2xp
Y3k/CgpTZWUgdXN1YWxseSBMaW51eCBrZXJuZWwgY29kZSBjb21wYXRpYmlsaXR5IHBvbGljeSBp
cyB0aGF0IGV4aXN0aW5nIApzdHVmZiBuZWVkcyB0byB3b3JrIGZvcmV2ZXIuCgpXZSBjb3VsZCBh
cmd1ZSBhIGJpdCB0aGF0IHRoZSBoeXBlcnZpc29yIGNvbXBvbmVudHMgYXJlIG5vdCBvcGVuIHNv
dXJjZSAKbm9yIHVBUEksIGJ1dCB0aGF0IGFyZ3VtZW50IGlzIHJhdGhlciB0aGluLgoKQ2hyaXN0
aWFuLgoKQW0gMDQuMDYuMjEgdW0gMTU6MjMgc2NocmllYiBMdW8sIFpoaWdhbmc6Cj4gW0FNRCBP
ZmZpY2lhbCBVc2UgT25seV0KPgo+IEhlcmUgaXMgb3VyIGh5cGVydmlzb3IgZHJpdmVyIGNvbXBh
dGliaWxpdHkgcG9saWN5Ogo+ICAgICAgICAgIC0gSG9zdC55IHN1cHBvcnRzIEd1ZXN0LnktMSwg
R3Vlc3QueSwgR3Vlc3QueSsxCj4gICAgICAgICAgLSBHdWVzdC55IHN1cHBvcnRlZCBieSBIb3N0
LnktMSwgSG9zdC55LEhvc3QueSsxCj4KPiBIb3N0IGRyaXZlciBoYWQgdGhlIGZlYXR1cmUgZm9y
IGdmeDkgMiB5ZWFycyBhZ28uIFNvLCB0aGlzIGNoYW5nZSBtZWV0IG91ciBjb21wYXRpYmlsaXR5
IHBvbGljeS4KPgo+IFRoYW5rcywKPiBaaGlnYW5nCj4KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQo+IEZyb206IENocmlzdGlhbiBLw7ZuaWcgPGNrb2VuaWcubGVpY2h0enVtZXJrZW5AZ21h
aWwuY29tPgo+IFNlbnQ6IEp1bmUgNCwgMjAyMSA3OjE0IEFNCj4gVG86IERlbmcsIEVtaWx5IDxF
bWlseS5EZW5nQGFtZC5jb20+OyBMaXUsIFNoYW95dW4gPFNoYW95dW4uTGl1QGFtZC5jb20+OyBM
dW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZwo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS81XSBkcm0vYW1kZ3B1OiByZW1vdmUgc3Jp
b3YgdmYgY2hlY2tpbmcgZnJvbSBnZXR0aW5nIGZiIGxvY2F0aW9uCj4KPiBJIHdhcyBqdXN0IGFi
b3V0IHRvIHF1ZXN0aW9uIHRoZSBzYW1lIHRoaW5nLgo+Cj4gSXQgbG9va3MgcmVhbGx5IGdvb2Qg
dG8gbWUgdG8gaGF2ZSB0aGF0IGNsZWFuZWQgdXAsIGJ1dCBpZiB0aGlzIGJyZWFrcyB3aXRoIG9s
ZGVyIHZlcnNpb25zIG9mIHRoZSBoeXBlcnZpc29yIHRoZW4gaXQgaXMgYSBiaXQgcXVlc3Rpb25h
YmxlIGNoYW5nZS4KPgo+IFJlZ2FyZHMsCj4gQ2hyaXN0aWFuLgo+Cj4gQW0gMDQuMDYuMjEgdW0g
MDM6MTMgc2NocmllYiBEZW5nLCBFbWlseToKPj4gRG8gd2UgbmVlZCB0byBjb25zaWRlciBiYWNr
d2FyZCBjb21wYXRpYmlsaXR5Pwo+Pgo+Pgo+PiBCZXN0IHdpc2hlcwo+PiBFbWlseSBEZW5nCj4+
Cj4+Cj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+Pj4gRnJvbTogYW1kLWdmeCA8YW1k
LWdmeC1ib3VuY2VzQGxpc3RzLmZyZWVkZXNrdG9wLm9yZz4gT24gQmVoYWxmIE9mCj4+PiBMaXUs
IFNoYW95dW4KPj4+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDMsIDIwMjEgMTE6MTAgUE0KPj4+IFRv
OiBMdW8sIFpoaWdhbmcgPFpoaWdhbmcuTHVvQGFtZC5jb20+OyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+Pj4gQ2M6IEx1bywgWmhpZ2FuZyA8WmhpZ2FuZy5MdW9AYW1kLmNvbT4KPj4+
IFN1YmplY3Q6IFJFOiBbUEFUQ0ggMS81XSBkcm0vYW1kZ3B1OiByZW1vdmUgc3Jpb3YgdmYgY2hl
Y2tpbmcgZnJvbQo+Pj4gZ2V0dGluZyBmYiBsb2NhdGlvbgo+Pj4KPj4+IFtBTUQgT2ZmaWNpYWwg
VXNlIE9ubHldCj4+Pgo+Pj4gTG9va3Mgb2sgdG8gbWUgLgo+Pj4KPj4+IFJldmlld2VkLUJ5IDog
U2hhb3l1bi5saXUgPHNoYW95dW5sQGFtZC5jb20+Cj4+Pgo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0KPj4+IEZyb206IGFtZC1nZnggPGFtZC1nZngtYm91bmNlc0BsaXN0cy5mcmVlZGVz
a3RvcC5vcmc+IE9uIEJlaGFsZiBPZgo+Pj4gWmhpZ2FuZyBMdW8KPj4+IFNlbnQ6IFRodXJzZGF5
LCBKdW5lIDMsIDIwMjEgMTA6MTMgQU0KPj4+IFRvOiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9w
Lm9yZwo+Pj4gQ2M6IEx1bywgWmhpZ2FuZyA8WmhpZ2FuZy5MdW9AYW1kLmNvbT4KPj4+IFN1Ympl
Y3Q6IFtQQVRDSCAxLzVdIGRybS9hbWRncHU6IHJlbW92ZSBzcmlvdiB2ZiBjaGVja2luZyBmcm9t
Cj4+PiBnZXR0aW5nIGZiIGxvY2F0aW9uCj4+Pgo+Pj4gaG9zdCBkcml2ZXIgcHJvZ3JhbW1lZCBm
YiBsb2NhdGlvbiByZWdpc3RlcnMgZm9yIHZmLCBubyBuZWVkIHRvIGNoZWNrIGFueW1vcmUuCj4+
Pgo+Pj4gU2lnbmVkLW9mZi1ieTogWmhpZ2FuZyBMdW8gPHpoaWdhbmcubHVvQGFtZC5jb20+Cj4+
PiAtLS0KPj4+IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMgfCA1ICstLS0t
Cj4+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2dtY192OV8wLmMKPj4+
IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvZ21jX3Y5XzAuYwo+Pj4gaW5kZXggY2ViMzk2
OGQ4MzI2Li4xYzJkOWZkZTkwMjEgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1k
L2FtZGdwdS9nbWNfdjlfMC5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9n
bWNfdjlfMC5jCj4+PiBAQCAtMTI5MiwxMCArMTI5Miw3IEBAIHN0YXRpYyBpbnQgZ21jX3Y5XzBf
bGF0ZV9pbml0KHZvaWQgKmhhbmRsZSkKPj4+IHN0YXRpYyB2b2lkIGdtY192OV8wX3ZyYW1fZ3R0
X2xvY2F0aW9uKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgYW1kZ3B1X2dtYyAqbWMpCj4+PiB7Cj4+PiAt
ICAgIHU2NCBiYXNlID0gMDsKPj4+IC0KPj4+IC0gICAgaWYgKCFhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpCj4+PiAtICAgICAgICAgICAgYmFzZSA9IGFkZXYtPm1taHViLmZ1bmNzLT5nZXRfZmJfbG9j
YXRpb24oYWRldik7Cj4+PiArICAgIHU2NCBiYXNlID0gYWRldi0+bW1odWIuZnVuY3MtPmdldF9m
Yl9sb2NhdGlvbihhZGV2KTsKPj4+Cj4+PiAgICAgICAvKiBhZGQgdGhlIHhnbWkgb2Zmc2V0IG9m
IHRoZSBwaHlzaWNhbCBub2RlICovCj4+PiAgICAgICBiYXNlICs9IGFkZXYtPmdtYy54Z21pLnBo
eXNpY2FsX25vZGVfaWQgKiBhZGV2LQo+Pj4+IGdtYy54Z21pLm5vZGVfc2VnbWVudF9zaXplOwo+
Pj4gLS0KPj4+IDIuMTcuMQo+Pj4KPj4+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCj4+PiBhbWQtZ2Z4IG1haWxpbmcgbGlzdAo+Pj4gYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKPj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24u
b3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxpcwo+Pj4gdHMuZnJlCj4+PiBlZGVza3Rv
cC5vcmclMkZtYWlsbWFuJTJGbGlzdGluZm8lMkZhbWQtCj4+PiBnZngmYW1wO2RhdGE9MDQlN0Mw
MSU3Q0VtaWx5LkRlbmclNDBhbWQuY29tJTdDZDQxZTc4YjFhM2FmNGYwOGZmCj4+PiBkMTA4ZDky
NmExYTJkOCU3QzNkZDg5NjFmZTQ4ODRlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3QzAlN0M2Mwo+
Pj4gNzU4MzI5Nzk0NjI0MjI3MSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdM
akF3TURBaQo+Pj4gTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1uMCUz
RCU3QzEwMDAmYW1wO3NkYXRhPU5zego+Pj4gWnlSWkhDeGolMkZJSjFoWW9Tcmt2M0xwVG1GOUZi
Y2hwTk10UTJHRTVNJTNEJmFtcDtyZXNlcnZlZD0wCj4+PiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+Pj4gYW1kLWdmeCBtYWlsaW5nIGxpc3QKPj4+IGFt
ZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+PiBodHRwczovL25hbTExLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXMKPj4+IHRzLmZyZQo+
Pj4gZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLQo+Pj4gZ2Z4JmFtcDtk
YXRhPTA0JTdDMDElN0NFbWlseS5EZW5nJTQwYW1kLmNvbSU3Q2Q0MWU3OGIxYTNhZjRmMDhmZgo+
Pj4gZDEwOGQ5MjZhMWEyZDglN0MzZGQ4OTYxZmU0ODg0ZTYwOGUxMWE4MmQ5OTRlMTgzZCU3QzAl
N0MwJTdDNjMKPj4+IDc1ODMyOTc5NDYyNDIyNzElN0NVbmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlK
V0lqb2lNQzR3TGpBd01EQWkKPj4+IExDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENK
WFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT1Oc3oKPj4+IFp5UlpIQ3hqJTJGSUoxaFlvU3Jr
djNMcFRtRjlGYmNocE5NdFEyR0U1TSUzRCZhbXA7cmVzZXJ2ZWQ9MAo+PiBfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBhbWQtZ2Z4IG1haWxpbmcgbGlz
dAo+PiBhbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiBodHRwczovL25hbTExLnNhZmVs
aW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZsaXN0Cj4+IHMu
ZnJlZWRlc2t0b3Aub3JnJTJGbWFpbG1hbiUyRmxpc3RpbmZvJTJGYW1kLWdmeCZhbXA7ZGF0YT0w
NCU3QzAxJTdDWmgKPj4gaWdhbmcuTHVvJTQwYW1kLmNvbSU3QzliODdkZmExOTVlZDRlODRhOGM4
MDhkOTI3NDllNDE2JTdDM2RkODk2MWZlNDg4NAo+PiBlNjA4ZTExYTgyZDk5NGUxODNkJTdDMCU3
QzAlN0M2Mzc1ODQwMjA1ODE0NjAxMTglN0NVbmtub3duJTdDVFdGcGJHWnNiCj4+IDNkOGV5SldJ
am9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJNk1u
MCUzRCUKPj4gN0MxMDAwJmFtcDtzZGF0YT0zUzZaRW5DQ01ISGxmYyUyQjZ4bUxEejdCZ245MUlz
N0VJcE1TN1dSeHEwSm8lM0QmYW1wOwo+PiByZXNlcnZlZD0wCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2FtZC1nZngK
