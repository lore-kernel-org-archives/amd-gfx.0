Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F07EECD6E57
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 10:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C63D10EE37;
	Tue,  2 Jun 2026 10:04:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="A5qRbJMW";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BA7310EE37
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780394661; x=1780653861;
 bh=8yitcGedObR7T+mmA4PMc99vOGJuoP0FGUiv0c6lB3E=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=A5qRbJMWf5kCP3b4ltI0jE+f6xZ5OD6DOdz9oNUzlT5QCFS5vJt0MLzyUd9nU5Jmb
 Ldsvo8ApMAbCUJ6iPgXFoGQ/lWadX7xpfufQOLqT2fFzDLxyaTgnNnjP4j+86ISUra
 CwGRoGkGAFOZku+d/maaMGKRqEqWkkjQEzkZ5hmo3N+5UTnQynFttXY7BjLozKRCC7
 dOK5vMFIntNWk4f6FVfKR9YmLhKi87QunqjV3ECors/WCiWLrgtpD/ZQ71cg0Eqf76
 r0adLdAM/R0jB0pu/ruz4vflpHgBFfT0g73jganzdaS7yuGO2WLmBK2XJluTIYnI1y
 9jYPnN6X+nMHw==
Date: Tue, 02 Jun 2026 10:04:16 +0000
To: regressions@lists.linux.dev
From: Gerhard Schwanzer <geschw@pm.me>
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 alexander.deucher@amd.com, xiaogang.chen@amd.com, Philip.Yang@amd.com
Subject: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes SDMA0
 permission fault on RX 7600 XT
Message-ID: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
Feedback-ID: 110185885:user:proton
X-Pm-Message-ID: 3827eb5612f6249c3e3ac56190779809977b43b4
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------b1d22f524bd0fce574b9f8951abc473a1600bb6c1d38a6de76fecad1260b7fd4";
 charset=utf-8
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------b1d22f524bd0fce574b9f8951abc473a1600bb6c1d38a6de76fecad1260b7fd4
Content-Type: multipart/mixed;
 boundary=1ea919c22093f7c70f318045009b12ce5122f2e65a6c40e57fa1a7b4729f
Message-ID: <2bfa2f1b-567a-429b-aee2-a8dcf7efd5aa@pm.me>
Date: Tue, 2 Jun 2026 11:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gerhard Schwanzer <geschw@pm.me>
Subject: [REGRESSION] drm/amdkfd: SVM split-tail remap regression causes SDMA0
 permission fault on RX 7600 XT
To: regressions@lists.linux.dev
Cc: amd-gfx@lists.freedesktop.org, stable@vger.kernel.org,
 alexander.deucher@amd.com, xiaogang.chen@amd.com, Philip.Yang@amd.com
Content-Language: en-US

--1ea919c22093f7c70f318045009b12ce5122f2e65a6c40e57fa1a7b4729f
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8; format=flowed

SGksDQoNCkkgd291bGQgbGlrZSB0byBtYWtlIHN1cmUgdGhpcyBBTURLRkQgU1ZNIHJlZ3Jlc3Np
b24gaXMgdHJhY2tlZCBieSB0aGUNCkxpbnV4IHJlZ3Jlc3Npb24gcHJvY2Vzcy4NCg0KR2l0TGFi
IHJlcG9ydDoNCg0KIMKgIGh0dHBzOi8vZ2l0bGFiLmZyZWVkZXNrdG9wLm9yZy9kcm0vYW1kLy0v
d29ya19pdGVtcy80OTE0DQoNClRoZSByZWdyZXNzaW9uIHdhcyBvcmlnaW5hbGx5IHJlcG9ydGVk
IG9uIDIwMjYtMDEtMjcuIEl0IHdhcyBiaXNlY3RlZCB0byB0aGUNCnNhbWUgZnVuY3Rpb25hbCBj
aGFuZ2UgdGhhdCBBbGV4IERldWNoZXIncyByZXZlcnQgcGF0Y2ggbGF0ZXIgdGFyZ2V0ZWQ6DQoN
CiDCoCA0NDhlZTQ1MzUzZWY5ZmIxYTM0ZjVmMjZlYjNmNDg5MjNjNmYwODk4DQogwqAgZHJtL2Ft
ZGtmZDogVXNlIGh1Z2UgcGFnZSBzaXplIHRvIGNoZWNrIHNwbGl0IHN2bSByYW5nZSBhbGlnbm1l
bnQNCg0KVGhlIGFmZmVjdGVkIGtlcm5lbCBsaW5lIEkgdGVzdGVkIGlkZW50aWZpZXMgdGhlIHNh
bWUgY2hhbmdlIGFzOg0KDQogwqAgYmYyMDg0YTdiMWQ3NWQwOTNiNmE3OWRmNGMxMDE0MmQ0OWZi
YWEwZQ0KDQpBbGV4J3MgcmV2ZXJ0IHBhdGNoOg0KDQpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9hcmNoaXZlcy9hbWQtZ2Z4LzIwMjYtRmVicnVhcnkvMTM4ODI0Lmh0bWwNCg0KQSBzbWFs
bCBDL0hTQSByZXByb2R1Y2VyIGlzIG5vdyBhdmFpbGFibGUgaW4gdGhlIEdpdExhYiByZXBvcnQu
IEl0IGRvZXMgbm90DQpyZXF1aXJlIFB5VG9yY2gsIENvbWZ5VUksIERvY2tlciwgbW9kZWwgZmls
ZXMsIG9yIHRoZSBvcmlnaW5hbCB3b3JrbG9hZC4gSXQNCnVzZXMgUk9Dci9IU0EsIGFuIGFub255
bW91cyBUSFAtYWR2aXNlZCBob3N0IG1hcHBpbmcsIGV4cGxpY2l0IEtGRCBTVk0NClNFVF9BVFRS
IGlvY3RscywgYW5kIGFuIEhTQSBTRE1BIEQySCBjb3B5Lg0KDQpTaW5nbGUgcmVwcm9kdWNlciBj
b21tYW5kLCBzYW1lIGJpbmFyeSBvbiBib3RoIGtlcm5lbHM6DQoNCiDCoCAuL2tmZF9zdm1fc3Bs
aXRfaHNhX2NvcHkgLS11cHN0cmVhbS1hYg0KDQpTYW1lLW1hY2hpbmUgQS9CIHJlc3VsdCBvbiBh
biBSWCA3NjAwIFhUOg0KDQogwqAgNDQ4ZWU0NTMvYmYyMDg0YTcgYWN0aXZlOg0KIMKgIMKgIDEv
MSBydW4gZmF1bHRzIHdpdGggU0RNQTAgcGVybWlzc2lvbiBmYXVsdA0KIMKgIMKgIEdDVk1fTDJf
UFJPVEVDVElPTl9GQVVMVF9TVEFUVVM9MHgwMDg0MUE1MQ0KDQogwqAgNDQ4ZWU0NTMvYmYyMDg0
YTcgbG9jYWxseSByZXZlcnRlZDoNCiDCoCDCoCAxMC8xMCBydW5zIGNvbXBsZXRlDQogwqAgwqAg
bm8gUk9DciBtZW1vcnkgYWNjZXNzIGZhdWx0DQogwqAgwqAgbm8gbmV3IEdDVk0vU0RNQTAgcGVy
bWlzc2lvbiBmYXVsdCBpbiBkbWVzZw0KDQpUaGUgYmFkIGZhdWx0IHBhZ2UgaXMgaW5zaWRlIHRo
ZSBzcGxpdCB0YWlsIGFuZCBpbnNpZGUgdGhlIFNETUEgY29weSByYW5nZToNCg0KIMKgIGNyaXRp
Y2FsIHRhaWw6IFsweDcyMjQyOWQ2MS4uMHg3MjI0MjlkZmZdDQogwqAgY29weSBwYWdlczrCoCDC
oCBbMHg3MjI0MjliMzAuLjB4NzIyNDI5ZDcwXQ0KIMKgIGZhdWx0IHBhZ2U6wqAgwqAgMHg3MjI0
MjlkNjUNCg0KQSBmdWxsIGZ0cmFjZS9QVEUgcnVuIHdpdGggdGhlIHNhbWUgQyByZXByb2R1Y2Vy
L1NWTSBzZXF1ZW5jZSBhbHNvIHNob3dzOg0KDQogwqAgc3BsaXRfdGFpbCAuLi4gY3VycmVudF9y
ZW1hcD0wIG9sZF9yZW1hcD0xIG1pc3NlZD0xDQogwqAgTUlTU0VEX1JFTUFQX0NBTkRJREFURSBz
cGxpdD10YWlsDQogwqAgbm8gYW1kZ3B1X3ZtX3VwZGF0ZV9wdGVzIGNvdmVyaW5nIHRoZSBmYXVs
dCBwYWdlIGFmdGVyIHRoZSBtYXJrZXIgYmVmb3JlDQogwqAgdGhlIGZhdWx0LXNpZGUgR0VUX0FU
VFINCg0KVGhlIHN1c3BlY3RlZCBjb2RlIGlzc3VlIGlzIHRoYXQgdGhlIHNwbGl0LXRhaWwvaGVh
ZCByZW1hcCBwcmVkaWNhdGUgDQppbnRyb2R1Y2VkDQpieSA0NDhlZTQ1My9iZjIwODRhNyBjYW4g
bWlzcyB0YWlscyBpbnNpZGUgdGhlIGZpbmFsIDUxMi1wYWdlIGJsb2NrLiBTaW5jZQ0KcHJhbmdl
LT5sYXN0IGlzIGluY2x1c2l2ZSwgQUxJR05fRE9XTihwcmFuZ2UtPmxhc3QsIDUxMikgaXMgdGhl
IHN0YXJ0IG9mIHRoZQ0KZmluYWwgYmxvY2ssIG5vdCBhbiBleGNsdXNpdmUgdXBwZXIgYm91bmQu
DQoNCkkgYWxzbyBzZW50IGEgc2hvcnQgZm9sbG93LXVwIHRvIGFtZC1nZnggd2l0aCB0aGUgcmVw
cm9kdWNlci9BLUIgc3VtbWFyeSBhbmQNCmFza2VkIHdoYXQgb3JpZ2luYWwgZmFpbHVyZSBvciB3
b3JrbG9hZCA0NDhlZTQ1My9iZjIwODRhNyB3YXMgaW50ZW5kZWQgDQp0byBmaXg6DQoNCmh0dHBz
Oi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL2FyY2hpdmVzL2FtZC1nZngvMjAyNi1KdW5lLzE0NTgw
MC5odG1sDQoNCkkgY2FuIHJlc2VuZCB0aGUgcmVwcm9kdWNlciBzb3VyY2UgYW5kIHN1bW1hcmll
cyBkaXJlY3RseSBvbi1saXN0IGlmIA0KcHJlZmVycmVkLg0KDQojcmVnemJvdCBpbnRyb2R1Y2Vk
OiA0NDhlZTQ1MzUzZWY5ZmIxYTM0ZjVmMjZlYjNmNDg5MjNjNmYwODk4DQojcmVnemJvdCBtb25p
dG9yOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcvZHJtL2FtZC8tL3dvcmtfaXRlbXMv
NDkxNA0KDQpUaGFua3MsDQpHZXJoYXJkIFNjaHdhbnplcg0K
--1ea919c22093f7c70f318045009b12ce5122f2e65a6c40e57fa1a7b4729f
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - geschw@pm.me -
 0xE32DB141.asc"; name="publickey - geschw@pm.me - 0xE32DB141.asc"
Content-Type: application/pgp-keys; filename="publickey - geschw@pm.me -
 0xE32DB141.asc"; name="publickey - geschw@pm.me - 0xE32DB141.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCkNvbW1lbnQ6IGh0dHBzOi8vZ29w
ZW5wZ3Aub3JnClZlcnNpb246IEdvcGVuUEdQIDIuOS4wCgp4ak1FYWFZQ0loWUpLd1lCQkFIYVJ3
OEJBUWRBTDhzSFhxTDN5Q21KNUp6d3FEQ0hkWTZoSTJRQTM1TWx6Q082CkpyMTNWakRORzJkbGMy
Tm9kMEJ3YlM1dFpTQThaMlZ6WTJoM1FIQnRMbTFsUHNMQUVRUVRGZ29BZ3dXQ2FhWUMKSWdNTENR
Y0pFSGJ4WHM4VnA1eFpSUlFBQUFBQUFCd0FJSE5oYkhSQWJtOTBZWFJwYjI1ekxtOXdaVzV3WjNC
cQpjeTV2Y21mbmRLQmtNZmZLVmQvNWFFclk3VjRWR2g3L3U4Zm45OTQrQUZhemswRGF3UU1WQ2dn
RUZnQUNBUUlaCkFRS2JBd0llQVJZaEJPTXRzVUVPWXNWaEJITnZ1M2J4WHM4VnA1eFpBQUErZlFE
L2RFSXQyZGw1WUVwVFdBSkEKRU16MnlDOXNmTHJQN1piRm8vZytYcUlkNDNjQS8yaGlPUTJ1ZlB1
VXlJbVBNU2xMRUJjV0pCWkxlVDJqRHVyeQpMSGNadmVJRHpqZ0VhYVlDSWhJS0t3WUJCQUdYVlFF
RkFRRUhRQ0cyL0RXd2Z4R253S3hUUzF6MUluSkV2TkhqCm5WTndheE4rc1NjWFNvME1Bd0VJQjhL
K0JCZ1dDZ0J3QllKcHBnSWlDUkIyOFY3UEZhZWNXVVVVQUFBQUFBQWMKQUNCellXeDBRRzV2ZEdG
MGFXOXVjeTV2Y0dWdWNHZHdhbk11YjNKbkVIUDBza2ZMVDBsWWV6OHJLYW5Vb2E3YwpYekhFSmt4
TkxoSlhuM2JJOXpZQ213d1dJUVRqTGJGQkRtTEZZUVJ6Yjd0MjhWN1BGYWVjV1FBQU1LY0JBTTNt
CjlxYmt1cm9DTFdBMzZXMHhnRXJTaVBhdTNwTDR4c28yOFRzcUlCaE5BUDlQODhPYm41dnZzYmp1
V29VaE4wWU4KeEVXQnpuQ1dsZmtPQ1ppOTBNaFFCQT09Cj1hbmNVCi0tLS0tRU5EIFBHUCBQVUJM
SUMgS0VZIEJMT0NLLS0tLS0=
--1ea919c22093f7c70f318045009b12ce5122f2e65a6c40e57fa1a7b4729f--

--------b1d22f524bd0fce574b9f8951abc473a1600bb6c1d38a6de76fecad1260b7fd4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmoeqqAJEHbxXs8Vp5xZNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmctF4Bo6pC5YvBC7JAYk3jUFiEE4y2xQQ5ixWEE
c2+7dvFezxWnnFkAAM/1AP9HCiI9L8eb4WAGxlEFWmdV9NA0hfw7zvV55dtd
tLfxIQD/QL6fR3Qm/LieSsG4Mr6EPPDUQejl9Be7OfMq3qmjTwE=
=l8Wl
-----END PGP SIGNATURE-----


--------b1d22f524bd0fce574b9f8951abc473a1600bb6c1d38a6de76fecad1260b7fd4--

