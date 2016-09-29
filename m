From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: mutex_destroy in amdgpu_ctx_fini()
Date: Thu, 29 Sep 2016 11:18:11 +0000
Message-ID: <CY4PR12MB1768BBD9F3498EA5EB29C317F7CE0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SW4gdGhpcyBibG9jayBvZiBjb2RlIEknbSB3b25kZXJpbmcgaWYgdGhlIG11dGV4X2Rlc3Ryb3kg
c2hvdWxkIGJlIGhvaXN0ZWQgb3V0IG9mIHRoZSBpbm5lciBsb29wPwoKc3RhdGljIHZvaWQgYW1k
Z3B1X2N0eF9maW5pKHN0cnVjdCBhbWRncHVfY3R4ICpjdHgpCnsKwqAgwqAgwqAgwqAgc3RydWN0
IGFtZGdwdV9kZXZpY2UgKmFkZXYgPSBjdHgtPmFkZXY7CsKgIMKgIMKgIMKgIHVuc2lnbmVkIGks
IGo7CgoKwqAgwqAgwqAgwqAgaWYgKCFhZGV2KQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1
cm47CgoKwqAgwqAgwqAgwqAgZm9yIChpID0gMDsgaSA8IEFNREdQVV9NQVhfUklOR1M7ICsraSkK
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZm9yIChqID0gMDsgaiA8IGFtZGdwdV9zY2hlZF9qb2Jz
OyArK2opIHsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmVuY2VfcHV0KGN0
eC0+cmluZ3NbaV0uZmVuY2VzW2pdKTsKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgbXV0ZXhfZGVzdHJveSgmY3R4LT5yaW5nc1tpXS5zZW1fbG9jayk7CsKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIH0KCgpDaGVlcnMsClRvbQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
