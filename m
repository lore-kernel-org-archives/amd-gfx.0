Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC02FA3743
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C43E010E717;
	Thu, 27 Oct 2022 21:53:54 +0000 (UTC)
X-Greylist: delayed 915 seconds by postgrey-1.36 at gabe;
 Thu, 27 Oct 2022 19:39:48 UTC
Received: from out20-217.mail.aliyun.com (out20-217.mail.aliyun.com
 [115.124.20.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21AA10E6C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 19:39:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.06613041|-1;
 BR=01201311R171S15rulernew998_84748_2000303; CH=blue; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_regular_dialog|0.364414-0.0244034-0.611183; FP=0|0|0|0|0|0|0|0;
 HT=ay29a033018047211; MF=i@estela.cn; NM=1; PH=DS; RN=10; RT=10; SR=0;
 TI=SMTPD_---.PtDLp8X_1666898666; 
Received: from 172.22.2.20(mailfrom:i@estela.cn
 fp:SMTPD_---.PtDLp8X_1666898666) by smtp.aliyun-inc.com;
 Fri, 28 Oct 2022 03:24:27 +0800
Message-ID: <d1157b52-c759-c765-8c74-aee43c23d6e2@estela.cn>
Date: Fri, 28 Oct 2022 03:24:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
From: Estela ad Astra <i@estela.cn>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Ao Zhong <hacc1225@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Language: en-US
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EwCLW7UL3rXP2OmHsB69w8XL"
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EwCLW7UL3rXP2OmHsB69w8XL
Content-Type: multipart/mixed; boundary="------------L3wKxdzGbNFopTQ9EUS2Vmo2";
 protected-headers="v1"
From: Estela ad Astra <i@estela.cn>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Arnd Bergmann
 <arnd@arndb.de>, Ao Zhong <hacc1225@gmail.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Message-ID: <d1157b52-c759-c765-8c74-aee43c23d6e2@estela.cn>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>
In-Reply-To: <8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com>

--------------L3wKxdzGbNFopTQ9EUS2Vmo2
Content-Type: multipart/alternative;
 boundary="------------4VJLXVre7WYwjPJMRagf6wIE"

--------------4VJLXVre7WYwjPJMRagf6wIE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8uDQoNCkkgaGF2ZSB0ZXN0ZWQgaXQgb24gYSBQaHl0aXVtIEQyMDAwIHBsYXRmb3Jt
IHdpdGggUlggNTUwMCBYVC4NCg0KRGlzdHJvOiBBcmNoIExpbnV4IEFSTQ0KDQpLZXJuZWw6
IExpbnV4IDYuMC41LTEtcGh5dGl1bSBhYXJjaDY0IChwYXRjaGVkLCANCmh0dHBzOi8vZ2l0
aHViLmNvbS9zYWV6aWFlL3BrZ2J1aWxkLWxpbnV4LXBoeXRpdW0gKQ0KDQpQbHVnIGFuZCB1
bnBsdWc6IE9LIG9uIGFsbCBwb3J0cy4NCg0KUmVzb2x1dGlvbnMgdGVzdGVkOsKgIDM4NDB4
MjE2MEA2MEh6LCAyNTYweDE0NDBANjBIeiwgMTkyMCoxMDgwQDYwSHoNCg0KRHVhbC1zY3Jl
ZW46IDM4NDB4MjE2MEA2MEh6IG9uIERQIHBsdXMgMjU2MHgxNDQwQDYwSHogb24gSERNSS4N
Cg0KR3JhcGhpYyBhcHBsaWNhdGlvbnM6IGdseGdlYXJzLiAxMDgwUCB2aWRlbyBvbiBNUFYg
KFZBQVBJKS4gTWluZWNyYWZ0Lg0KDQpJR1QgdGVzdDoNCg0KTW9zdCB0ZXN0cyB3ZW50IHdl
bGwsIHdpdGggYSBmZXcgZXJyb3IgbG9ncy4NCg0KICAgICA+IGNhdCBrbXNfZmxpcC5sb2d8
IGdyZXAgRkFJTA0KICAgIER5bmFtaWMgc3VidGVzdCBBLUhETUktQTE6IEZBSUwgKDAuMjAx
cykNCiAgICBTdWJ0ZXN0IGFic29sdXRlLXdmX3ZibGFuazogRkFJTCAoMjkuNTcxcykNCiAg
ICBEeW5hbWljIHN1YnRlc3QgQS1IRE1JLUExOiBGQUlMICgwLjE3MnMpDQogICAgU3VidGVz
dCBibG9ja2luZy1hYnNvbHV0ZS13Zl92Ymxhbms6IEZBSUwgKDI5LjUzN3MpDQogICAgRHlu
YW1pYyBzdWJ0ZXN0IEEtSERNSS1BMTogRkFJTCAoMC4yNTdzKQ0KICAgIFN1YnRlc3QgYmxv
Y2tpbmctYWJzb2x1dGUtd2ZfdmJsYW5rLWludGVycnVwdGlibGU6IEZBSUwgKDI5LjQ1OHMp
DQoNClBob3RvcyBhbmQgdmlkZW8gY2xpcHM6IGh0dHBzOi8vdC5tZS9lc3RlbGFkYWlseS8z
MzQNCg0KVGhhbmsgeW91IGZvciBhbGwgeW91IGd1eXMnIGV4Y2VsbGVudCB3b3JrLg0KDQoN
Ck9uIDI3LzEwLzIwMjIgMjI6MjksIFJvZHJpZ28gU2lxdWVpcmEgd3JvdGU6DQo+IEhpIEFv
L0FybmQvU3RlcGhlbi9OYXRoYW4sDQo+DQo+IEFvLA0KPg0KPiBUaGFua3MgYSBsb3QgZm9y
IHRoaXMgbmV3IHBhdGNoLg0KPg0KPiBTaW5jZSB5b3UgaGF2ZSBhbiBBUk02NCArIEFNRCBH
UFUsIGNvdWxkIHlvdSBhbHNvIHJ1biBhIGNvdXBsZSBvZiANCj4gdGVzdHMgaW4geW91ciBz
ZXR1cD8gSWYgc28sIHRoaXMgaXMgYSBnb29kIHNldCBvZiB0ZXN0cyBpbWhvOg0KPg0KPiAx
LiBDaGVjayBwbHVnIGFuZCB1bnBsdWcgZGlzcGxheXMgKGxldCBzYXlzIDV4KQ0KPiAyLiBD
aGFuZ2UgcmVzb2x1dGlvbnMNCj4gMy4gKG1vc3Qgd2FudGVkIHRlc3QpIENvdWxkIHlvdSBy
dW4gc29tZSBJR1QgdGVzdHM/DQo+DQo+IEFib3V0IElHVCwgdGhpcyBpcyB0aGUgb2ZmaWNp
YWwgcmVwb3NpdG9yeToNCj4NCj4gaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2Ry
bS9pZ3QtZ3B1LXRvb2xzDQo+DQo+IEl0IHNob3VsZCBiZSBlYXN5IHRvIHJ1biBJR1QgaW4g
eW91ciBzeXN0ZW0uIEZvbGxvdyBhIGJyaWVmIHN1bW1hcnk6DQo+DQo+IDEuIEluc3RhbGwg
ZGVwZW5kZW5jaWVzDQo+DQo+IChtYXliZSBJIG1pc3NlZCBzb21ldGhpbmcpDQo+DQo+IERl
Ymlhbg0KPiBhcHQgaW5zdGFsbCBmbGV4IGJpc29uIHBrZy1jb25maWcgeDExcHJvdG8tZHJp
Mi1kZXYgcHl0aG9uLWRvY3V0aWxzIA0KPiB2YWxncmluZCBwZWcgbGlicGNpYWNjZXNzLWRl
diBsaWJrbW9kLWRldiBsaWJwcm9jcHMtZGV2IGxpYnVud2luZC1kZXYgDQo+IGxpYmR3LWRl
diB6bGliMWctZGV2IGxpYmx6bWEtZGV2IGxpYmNhaXJvLWRldiBsaWJwaXhtYW4tMS1kZXYg
DQo+IGxpYnVkZXYtZGV2IGxpYmdzbC1kZXYgbGliYXNvdW5kMi1kZXYgbGlianNvbi1jLWRl
diANCj4gbGliY3VybDQtb3BlbnNzbC1kZXYgbGlieHJhbmRyLWRldiBsaWJ4di1kZXYgbWVz
b24gbGliZHJtLWRldiANCj4gcWVtdS11c2VyIHFlbXUtdXNlci1zdGF0aWMNCj4NCj4gQXJj
aExpbnV4DQo+IHBhY21hbiAtUyBnY2MgZmxleCBiaXNvbiBwa2ctY29uZmlnIGxpYnBjaWFj
Y2VzcyBrbW9kIHByb2Nwcy1uZyANCj4gbGlidW53aW5kIGxpYmR3YXJmIHpsaWIgeHogY2Fp
cm8gcGl4bWFuIGxpYnVkZXYwLXNoaW0gZ3NsIGFsc2EtbGliIA0KPiB4bWxycGMtYyBqc29u
LWMgY3VybCBsaWJ4cmFuZHIgbGlieHYgeG9yZ3Byb3RvIHB5dGhvbi1kb2N1dGlscyANCj4g
dmFsZ3JpbmQgcGVnIG1lc29uIGxpYmRybSBsaWJ0b29sIG1ha2UgYXV0b2NvbmYgYXV0b21h
a2UgZ3RrLWRvYyANCj4gcHl0aG9uLWRvY3V0aWxzIGdpdCB2aW0gc3Vkbw0KPg0KPiAyLiBC
dWlsZCBJR1QNCj4NCj4gbWVzb24gYnVpbGQgJiYgbmluamEgLUMgYnVpbGQNCj4NCj4gMy4g
VHVybiBvZmYgeW91ciBHVUkNCj4NCj4gKFlvdSBtdXN0IHJ1biBJR1Qgd2l0aG91dCBhbnkg
R1VJKQ0KPg0KPiBzdWRvIHN5c3RlbWN0bCBpc29sYXRlIG11bHRpLXVzZXIudGFyZ2V0DQo+
DQo+IEFmdGVyIHJ1biB0aGlzIGNvbW1hbmQsIHlvdSBzaG91bGQgc2VlIHRoZSBUVFkuDQo+
DQo+IDQuIFRyeSB0byBydW4gdGhpcyBJR1QgdGVzdA0KPg0KPiBzdWRvIC4vYnVpbGQvdGVz
dHMva21zX2ZsaXANCj4NCj4gQW5kIGxldCBtZSBrbm93IGlmIHRoaXMgdGVzdCBsb29rcyBv
ayBmb3IgeW91Lg0KPg0KPiBPbiAxMC8yNy8yMiAwNjo1MiwgQXJuZCBCZXJnbWFubiB3cm90
ZToNCj4+IE9uIFRodSwgT2N0IDI3LCAyMDIyLCBhdCAwMjoyNSwgQW8gWmhvbmcgd3JvdGU6
DQo+Pj4gQWZ0ZXIgbW92aW5nIGFsbCBGUFUgY29kZSB0byB0aGUgRE1MIGZvbGRlciwgd2Ug
Y2FuIGVuYWJsZSBEQ04gc3VwcG9ydA0KPj4+IGZvciB0aGUgQVJNNjQgcGxhdGZvcm0uIFJl
bW92ZSB0aGUgLW1nZW5lcmFsLXJlZ3Mtb25seSBDRkxBRyBmcm9tIHRoZQ0KPj4+IGNvZGUg
aW4gdGhlIERNTCBmb2xkZXIgdGhhdCBuZWVkcyB0byB1c2UgaGFyZHdhcmUgRlBVLCBhbmQg
YWRkIGEgDQo+Pj4gY29udHJvbA0KPj4+IG1lY2hhbmlzbSBmb3IgQVJNIE5lb24uDQo+DQo+
IEkgcmVjb21tZW5kIHlvdSB0byBhZGQgdGhlIGZvbGxvd2luZyBpbmZvIGluIHlvdXIgY29t
bWl0Og0KPg0KPiAxLiBTeXN0ZW0gdGhhdCB5b3UgdXNlIHRvIHZhbGlkYXRlIHRoaXMgY2hh
bmdlIChDUFUgbmFtZSwgbW9uaXRvciwgDQo+IGRpc3Rybywgd2F5bGFuZC9YLCBldGMpLg0K
PiAyLiBEZXNjcmliZSB0aGUgc2V0IG9mIHRlc3RzIHRoYXQgeW91IHRyaWVkLg0KPg0KPj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogQW8gWmhvbmcgPGhhY2MxMjI1QGdtYWlsLmNvbT4NCj4+
DQo+PiBUaGVyZSBoYXZlIGJlZW4gcHJvYmxlbXMgd2l0aCBzdGFjayBmcmFtZSBvdmVyZmxv
d3Mgb24gdGhpcyBjb2RlDQo+PiBpbiB0aGUgcGFzdCwgaG93IG11Y2ggaGF2ZSB5b3UgdGVz
dGVkIHRoaXMgd2l0aCByYW5kb20gY29uZmlndXJhdGlvbnMNCj4+IHRvIHNlZSBpZiB3ZSBz
dGlsbCBoaXQgdGhlbSBpbiBjb3JuZXIgY2FzZXMgb24gYXJtNjQgdGhhdCBtYXkgbm90DQo+
PiBzaG93IHVwIG9uIHg4NiBvciBwb3dlcnBjPyBJIHdvdWxkIGV4cGVjdCB0byBzZWUgYSBm
ZXcgbW9yZSBvZiB0aGVtDQo+PiBmb3IgZXZlcnkgbmV3IGFyY2hpdGVjdHVyZSBwb3J0Lg0K
Pg0KPiBIaSBBcm5kLA0KPg0KPiBXZSBmb2xsb3dlZCB5b3VyIHN1Z2dlc3Rpb24gdG8gaXNv
bGF0ZSBhbGwgRlBVIGNvZGUgaW5zaWRlIGEgc2luZ2xlIA0KPiBwbGFjZSAoRE1MKSwgYW5k
IHdlIHJlY2VudGx5IGNvbXBsZXRlZCBtb3N0IG9mIHRoaXMgdGFzay4gQXMgYSByZXN1bHQs
IA0KPiBhbGwgRlBVIGZsYWdzIGFyZSBvbmx5IHVzZWQgaW4gdGhlIERNTCBjb2RlLiBJIGd1
ZXNzIHdlIG1pZ2h0IGhhdmUgDQo+IGlzc3VlcyBpbiBvdGhlciBub24teDg2IHBsYXRmb3Jt
cywgYnV0IHRoaXMgaXMgc29tZXRoaW5nIHRoYXQgd2UgY2FuIA0KPiBpbXByb3ZlIG92ZXIg
dGltZSwgYW5kIGZyb20gQW8gbWVzc2FnZSwgaXQgbG9va3MgbGlrZSB0aGF0IERDTiBpcyAN
Cj4gd29ya2luZyBvbiBBUk0uDQo+DQo+IEF0IHRoaXMgcG9pbnQsIG15IG1haW4gY29uY2Vy
biBpcyB0aGF0IGVuYWJsaW5nIEFSTTY0IG1heSBjYXVzZXMgc29tZSANCj4gY29tcGlsYXRp
b24gaXNzdWVzIHRoYXQgd2UgZGlkIG5vdCByZXByb2R1Y2UgeWV0LiBJIGNyb3NzLWNvbXBp
bGVkIA0KPiBhbWQtc3RhZ2luZy1kcm0tbmV4dCArIHRoaXMgcGF0Y2ggd2l0aCBhYXJjaDY0
LWxpbnV4LWdudS1nY2MgdmVyc2lvbiANCj4gMTIuMi4wIGFuZCBldmVyeXRoaW5nIGxvb2tz
IGZpbmUuDQo+DQo+IE5hdGhhbi9TdGVwaGVuLA0KPg0KPiBNYXliZSBJJ20gd3JvbmcsIGJ1
dCBJIHRoaW5rIHlvdSBoYXZlIGFjY2VzcyB0byBzb21lIHNvcnQgb2YgQ0kgdGhhdCANCj4g
dGVzdHMgbXVsdGlwbGUgYnVpbGRzIHdpdGggZGlmZmVyZW50IGNvbXBpbGVzIGFuZCBjb25m
aWdzLCByaWdodD8gSXMgDQo+IGl0IHBvc3NpYmxlIHRvIGNoZWNrIHRoaXMgcGF0Y2ggKyBh
bWQtc3RhZ2luZy1kcm0tbmV4dCBpbiB0aGUgQ0kgdG8gDQo+IGhlbHAgdXMgdG8gYW50aWNp
cGF0ZSBhbnkgY29tcGlsYXRpb24gaXNzdWUgaWYgd2UgbWVyZ2UgdGhpcyBjaGFuZ2U/DQo+
DQo+IE9yIHNob3VsZCB3ZSBtZXJnZSBpdCBhbmQgd2FpdCB1bnRpbCBpdCBnZXRzIG1lcmdl
ZCBvbiB0aGUgbWFpbmxpbmU/IA0KPiBJbiBjYXNlIG9mIGEgcHJvYmxlbSwgd2UgY2FuIGVh
c2lseSByZXZlcnQgYSBzbWFsbCBwYXRjaCBsaWtlIHRoaXMsIA0KPiByaWdodD8NCj4NCj4g
VGhhbmtzDQo+IFNpcXVlaXJhDQo+DQo+Pj4gaW5kZXggZDBjNmNmNjFjNjc2Li4zY2RkMTA5
MTg5ZTAgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2Rj
L2RtbC9NYWtlZmlsZQ0KPj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9k
Yy9kbWwvTWFrZWZpbGUNCj4+PiBAQCAtMzMsNiArMzMsMTIgQEAgaWZkZWYgQ09ORklHX1BQ
QzY0DQo+Pj4gwqAgZG1sX2NjZmxhZ3MgOj0gLW1oYXJkLWZsb2F0IC1tYWx0aXZlYw0KPj4+
IMKgIGVuZGlmDQo+Pj4NCj4+PiAraWZkZWYgQ09ORklHX0FSTTY0DQo+Pj4gK2lmZGVmIENP
TkZJR19EUk1fQU1EX0RDX0RDTg0KPj4+ICtkbWxfcmNmbGFnc19hcm02NCA6PSAtbWdlbmVy
YWwtcmVncy1vbmx5DQo+Pj4gK2VuZGlmDQo+Pj4gK2VuZGlmDQo+Pj4gKw0KPj4NCj4+PiBD
RkxBR1NfJChBTUREQUxQQVRIKS9kYy9kbWwvY2FsY3MvZGNuX2NhbGNzLm8gOj0gJChkbWxf
Y2NmbGFncykNCj4+PiDCoCBDRkxBR1NfJChBTUREQUxQQVRIKS9kYy9kbWwvY2FsY3MvZGNu
X2NhbGNfYXV0by5vIDo9ICQoZG1sX2NjZmxhZ3MpDQo+Pj4gwqAgQ0ZMQUdTXyQoQU1EREFM
UEFUSCkvZGMvZG1sL2NhbGNzL2Rjbl9jYWxjX21hdGgubyA6PSAkKGRtbF9jY2ZsYWdzKQ0K
Pj4+IC1Xbm8tdGF1dG9sb2dpY2FsLWNvbXBhcmUNCj4+PiAtQ0ZMQUdTX1JFTU9WRV8kKEFN
RERBTFBBVEgpL2RjL2RtbC9kaXNwbGF5X21vZGVfdmJhLm8gOj0gDQo+Pj4gJChkbWxfcmNm
bGFncykNCj4+PiArQ0ZMQUdTX1JFTU9WRV8kKEFNRERBTFBBVEgpL2RjL2RtbC9kaXNwbGF5
X21vZGVfdmJhLm8gOj0NCj4+PiAkKGRtbF9yY2ZsYWdzKSAkKGRtbF9yY2ZsYWdzX2FybTY0
KQ0KPj4NCj4+IFdoeSBkbyB5b3UgbmVlZCBzZXBhcmF0ZSAkKGRtbF9yY2ZsYWdzKSBhbmQg
JChkbWxfcmNmbGFnc19hcm02NCkNCj4+IHJhdGhlciB0aGFuIGFkZGluZyAtbWdlbmVyYWwt
cmVncy1vbmx5IHRvICQoZG1sX3JjZmxhZ3MpIGRpcmVjdGx5Pw0KPj4NCj4+IMKgwqDCoMKg
IEFybmQNCj4NCj4NCg==
--------------4VJLXVre7WYwjPJMRagf6wIE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hello.<br>
    </p>
    <p>I have tested it on a Phytium D2000 platform with RX 5500 XT.</p>
    <p>Distro: Arch Linux ARM<br>
    </p>
    <p>Kernel: Linux 6.0.5-1-phytium aarch64 (patched, <a
        class=3D"moz-txt-link-freetext"
        href=3D"https://github.com/saeziae/pkgbuild-linux-phytium">https:=
//github.com/saeziae/pkgbuild-linux-phytium</a>
      )<br>
    </p>
    <p>Plug and unplug: OK on all ports.<br>
    </p>
    <p>Resolutions tested:=C2=A0 3840x2160@60Hz, 2560x1440@60Hz,
      1920*1080@60Hz</p>
    <p>Dual-screen: 3840x2160@60Hz on DP plus 2560x1440@60Hz on HDMI.</p>=

    <p>Graphic applications: glxgears. 1080P video on MPV (VAAPI).
      Minecraft. <br>
    </p>
    <p>IGT test: <br>
    </p>
    <p>Most tests went well, with a few error logs.<br>
    </p>
    <blockquote>&gt; cat kms_flip.log| grep FAIL=C2=A0 =C2=A0<br>
      Dynamic subtest A-HDMI-A1: FAIL (0.201s)<br>
      Subtest absolute-wf_vblank: FAIL (29.571s)<br>
      Dynamic subtest A-HDMI-A1: FAIL (0.172s)<br>
      Subtest blocking-absolute-wf_vblank: FAIL (29.537s)<br>
      Dynamic subtest A-HDMI-A1: FAIL (0.257s)<br>
      Subtest blocking-absolute-wf_vblank-interruptible: FAIL (29.458s)<b=
r>
    </blockquote>
    <p>Photos and video clips: <a class=3D"moz-txt-link-freetext"
        href=3D"https://t.me/esteladaily/334">https://t.me/esteladaily/33=
4</a><br>
    </p>
    <p>Thank you for all you guys' excellent work.</p>
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 27/10/2022 22:29, Rodrigo Siqueira
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
      cite=3D"mid:8eb69dfb-ae35-dbf2-3f82-e8cc00e5389a@amd.com">Hi
      Ao/Arnd/Stephen/Nathan, <br>
      <br>
      Ao, <br>
      <br>
      Thanks a lot for this new patch. <br>
      <br>
      Since you have an ARM64 + AMD GPU, could you also run a couple of
      tests in your setup? If so, this is a good set of tests imho: <br>
      <br>
      1. Check plug and unplug displays (let says 5x) <br>
      2. Change resolutions <br>
      3. (most wanted test) Could you run some IGT tests? <br>
      <br>
      About IGT, this is the official repository: <br>
      <br>
      <a class=3D"moz-txt-link-freetext"
        href=3D"https://gitlab.freedesktop.org/drm/igt-gpu-tools">https:/=
/gitlab.freedesktop.org/drm/igt-gpu-tools</a>
      <br>
      <br>
      It should be easy to run IGT in your system. Follow a brief
      summary: <br>
      <br>
      1. Install dependencies <br>
      <br>
      (maybe I missed something) <br>
      <br>
      Debian <br>
      apt install flex bison pkg-config x11proto-dri2-dev
      python-docutils valgrind peg libpciaccess-dev libkmod-dev
      libprocps-dev libunwind-dev libdw-dev zlib1g-dev liblzma-dev
      libcairo-dev libpixman-1-dev libudev-dev libgsl-dev libasound2-dev
      libjson-c-dev libcurl4-openssl-dev libxrandr-dev libxv-dev meson
      libdrm-dev qemu-user qemu-user-static <br>
      <br>
      ArchLinux <br>
      pacman -S gcc flex bison pkg-config libpciaccess kmod procps-ng
      libunwind libdwarf zlib xz cairo pixman libudev0-shim gsl alsa-lib
      xmlrpc-c json-c curl libxrandr libxv xorgproto python-docutils
      valgrind peg meson libdrm libtool make autoconf automake gtk-doc
      python-docutils git vim sudo <br>
      <br>
      2. Build IGT <br>
      <br>
      meson build &amp;&amp; ninja -C build <br>
      <br>
      3. Turn off your GUI <br>
      <br>
      (You must run IGT without any GUI) <br>
      <br>
      sudo systemctl isolate multi-user.target <br>
      <br>
      After run this command, you should see the TTY. <br>
      <br>
      4. Try to run this IGT test <br>
      <br>
      sudo ./build/tests/kms_flip <br>
      <br>
      And let me know if this test looks ok for you. <br>
      <br>
      On 10/27/22 06:52, Arnd Bergmann wrote: <br>
      <blockquote type=3D"cite">On Thu, Oct 27, 2022, at 02:25, Ao Zhong
        wrote: <br>
        <blockquote type=3D"cite">After moving all FPU code to the DML
          folder, we can enable DCN support <br>
          for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG
          from the <br>
          code in the DML folder that needs to use hardware FPU, and add
          a control <br>
          mechanism for ARM Neon. <br>
        </blockquote>
      </blockquote>
      <br>
      I recommend you to add the following info in your commit: <br>
      <br>
      1. System that you use to validate this change (CPU name, monitor,
      distro, wayland/X, etc). <br>
      2. Describe the set of tests that you tried. <br>
      <br>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite"> <br>
          Signed-off-by: Ao Zhong <a class=3D"moz-txt-link-rfc2396E"
            href=3D"mailto:hacc1225@gmail.com">&lt;hacc1225@gmail.com&gt;=
</a>
          <br>
        </blockquote>
        <br>
        There have been problems with stack frame overflows on this code
        <br>
        in the past, how much have you tested this with random
        configurations <br>
        to see if we still hit them in corner cases on arm64 that may
        not <br>
        show up on x86 or powerpc? I would expect to see a few more of
        them <br>
        for every new architecture port. <br>
      </blockquote>
      <br>
      Hi Arnd, <br>
      <br>
      We followed your suggestion to isolate all FPU code inside a
      single place (DML), and we recently completed most of this task.
      As a result, all FPU flags are only used in the DML code. I guess
      we might have issues in other non-x86 platforms, but this is
      something that we can improve over time, and from Ao message, it
      looks like that DCN is working on ARM. <br>
      <br>
      At this point, my main concern is that enabling ARM64 may causes
      some compilation issues that we did not reproduce yet. I
      cross-compiled amd-staging-drm-next + this patch with
      aarch64-linux-gnu-gcc version 12.2.0 and everything looks fine. <br=
>
      <br>
      Nathan/Stephen, <br>
      <br>
      Maybe I'm wrong, but I think you have access to some sort of CI
      that tests multiple builds with different compiles and configs,
      right? Is it possible to check this patch + amd-staging-drm-next
      in the CI to help us to anticipate any compilation issue if we
      merge this change? <br>
      <br>
      Or should we merge it and wait until it gets merged on the
      mainline? In case of a problem, we can easily revert a small patch
      like this, right? <br>
      <br>
      Thanks <br>
      Siqueira <br>
      <br>
      <blockquote type=3D"cite">
        <blockquote type=3D"cite">index d0c6cf61c676..3cdd109189e0 100644=

          <br>
          --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile <br>
          +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile <br>
          @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64 <br>
          =C2=A0 dml_ccflags :=3D -mhard-float -maltivec <br>
          =C2=A0 endif <br>
          <br>
          +ifdef CONFIG_ARM64 <br>
          +ifdef CONFIG_DRM_AMD_DC_DCN <br>
          +dml_rcflags_arm64 :=3D -mgeneral-regs-only <br>
          +endif <br>
          +endif <br>
          + <br>
        </blockquote>
        <br>
        <blockquote type=3D"cite">=C2=A0
          CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o :=3D
          $(dml_ccflags) <br>
          =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o :=3D
          $(dml_ccflags) <br>
          =C2=A0 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o :=3D
          $(dml_ccflags) <br>
          -Wno-tautological-compare <br>
          -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D
          $(dml_rcflags) <br>
          +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o :=3D <br=
>
          $(dml_rcflags) $(dml_rcflags_arm64) <br>
        </blockquote>
        <br>
        Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
        <br>
        rather than adding -mgeneral-regs-only to $(dml_rcflags)
        directly? <br>
        <br>
        =C2=A0=C2=A0=C2=A0=C2=A0 Arnd <br>
      </blockquote>
      <br>
      <br>
    </blockquote>
  </body>
</html>

--------------4VJLXVre7WYwjPJMRagf6wIE--

--------------L3wKxdzGbNFopTQ9EUS2Vmo2--

--------------EwCLW7UL3rXP2OmHsB69w8XL
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEztujnldrxsIbcaZIJegrvqMr1HYFAmNa2uQACgkQJegrvqMr
1HY6mBAAjDazNLVVJVSHzKPAH48ATv49SoZyOY0D7g/nVkjDBmRtkv8dXELYFHPc
3xT+afSlbHWhfmjaQriaRWc/o8MNNTUPWbNlEmPkgDpoJrz53bNO/Io/YHejSyEi
qPSWO2MHzV5M52lE4ji0YtWqAZsVgapHwlM48zC072FuXQNmvjczevL+ytCKV1ri
vh6+qJuDocrLfM/cgaCf7g4UIBIrjoLzcllLpqt33fsiqJUcpG+S5m5OexnhcyNo
FbSInJ/q65/HZ1wYkISyAHoo/pHU8DSjofMzoWBOB7y1RKcad+oU26oMQcC8L7He
4d/El1t6QqMNsLbu/3E8R0CAVyUG2jYS17e9M2HnoFB92R710yCtthzr1zA9Sdql
adajkFvX+jvDvasrF5AAHg5Cb8A1aDLKk0PxWhi4l7PbvoyWBt334/G8I542nmhl
fbn0z5BFbu+ah0iTT3TpLUu4jCjj6/stf7upRQID01C00GN6uci1fIqv4Xh2Xo/2
e52yDGcKpVbms8ZI8VR1Azg8TbvwRkSzXHvR6P1nY4ufsPg4P204e8PGd7OEAH68
MdAT/lKLMil5p/4Aq4oYepHYT0mYZaI9niNkpIAUeRSSl7A+G5nOMjiAhKL/W1I9
WILpgpt0mbMbZzTarRN4CqqNXTRqaywDaepcN/P6KjdaRk8EhBw=
=7cum
-----END PGP SIGNATURE-----

--------------EwCLW7UL3rXP2OmHsB69w8XL--
