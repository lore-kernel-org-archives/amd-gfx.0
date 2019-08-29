From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] dmr/amdgpu: Avoid HW GPU reset for RAS.
Date: Thu, 29 Aug 2019 14:08:13 +0000
Message-ID: <1444ae5f-0997-d1ce-3e1e-23fea8822c88@amd.com>
References: <1567022426-6612-1-git-send-email-andrey.grodzovsky@amd.com>
 <85798da5-a4f1-28d3-c80f-9f262743cac9@gmail.com>
 <9a46188b-b528-0d1f-8c3f-b6ce5b73649f@amd.com>
 <8c2b0bf3-47ff-ea3b-a682-7ec76240be4d@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1743228239=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <8c2b0bf3-47ff-ea3b-a682-7ec76240be4d-5C7GfCeVMHo@public.gmane.org>
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
To: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============1743228239==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1444ae5f0997d1ce3e1e23fea8822c88amdcom_"

--_000_1444ae5f0997d1ce3e1e23fea8822c88amdcom_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

QWdyZWUsIHRoZSBwbGFjZW1lbnQgb2YgYW1kZ3B1X2FtZGtmZF9wcmUvcG9zdCBfcmVzZXQgaW4g
YW1kZ3B1X2RldmljZV9sb2NrL3VubG9ja19hZGV2IGlzIGEgYml0IHdpZXJkLg0KDQpBbmRyZXkN
Cg0KT24gOC8yOS8xOSAxMDowNiBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6DQoNCkZlbGl4
IGFkdmlzZWQgdGhhdCB0aGUgd2F5IHRvIHN0b3AgYWxsIEtGRCBhY3Rpdml0eSBpcyBzaW1wbHkg
dG8gTk9UDQpjYWxsIGFtZGdwdV9hbWRrZmRfcG9zdF9yZXNldCBzbyB0aGF0IHdoeSBJIGFkZGVk
IHRoaXMuIERvIHlvdSBtZWFuIHlvdQ0KcHJlZmVyIGFtZGdwdV9hbWRrZmRfcG9zdF9yZXNldCB0
byBiZSBvdXRzaWRlIG9mIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYgPw0KDQoNClllcywgZXhh
Y3RseS4gSXQgZG9lc24ndCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHRoZSB1bmxvY2sgb3BlcmF0
aW9uIGluDQp0aGUgZmlyc3QgcGxhY2UsIGJ1dCByYXRoZXIgb25seSBzaWduYWxzIHRoZSBLRkQg
dGhhdCB0aGUgcmVzZXQgaXMNCmNvbXBsZXRlZC4NCg0KQ2hyaXN0aWFuLg0KDQoNCg==

--_000_1444ae5f0997d1ce3e1e23fea8822c88amdcom_
Content-Type: text/html; charset="utf-8"
Content-ID: <059E3061B12FBD4F90DF7A950310A483-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
Content-Transfer-Encoding: base64

PGh0bWw+DQo8aGVhZD4NCjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0i
dGV4dC9odG1sOyBjaGFyc2V0PXV0Zi04Ij4NCjwvaGVhZD4NCjxib2R5IHRleHQ9IiMwMDAwMDAi
IGJnY29sb3I9IiNGRkZGRkYiPg0KPHA+QWdyZWUsIHRoZSBwbGFjZW1lbnQgb2YgYW1kZ3B1X2Ft
ZGtmZF9wcmUvcG9zdCBfcmVzZXQgaW4gYW1kZ3B1X2RldmljZV9sb2NrL3VubG9ja19hZGV2IGlz
IGEgYml0IHdpZXJkLjwvcD4NCjxwPkFuZHJleTxicj4NCjwvcD4NCjxkaXYgY2xhc3M9Im1vei1j
aXRlLXByZWZpeCI+T24gOC8yOS8xOSAxMDowNiBBTSwgS29lbmlnLCBDaHJpc3RpYW4gd3JvdGU6
PGJyPg0KPC9kaXY+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBjaXRlPSJtaWQ6OGMyYjBiZjMt
NDdmZi1lYTNiLWE2ODItN2VjNzYyNDBiZTRkQGFtZC5jb20iPg0KPGJsb2NrcXVvdGUgdHlwZT0i
Y2l0ZSIgc3R5bGU9ImNvbG9yOiAjMDAwMDAwOyI+DQo8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJl
IiB3cmFwPSIiPkZlbGl4IGFkdmlzZWQgdGhhdCB0aGUgd2F5IHRvIHN0b3AgYWxsIEtGRCBhY3Rp
dml0eSBpcyBzaW1wbHkgdG8gTk9UDQpjYWxsIGFtZGdwdV9hbWRrZmRfcG9zdF9yZXNldCBzbyB0
aGF0IHdoeSBJIGFkZGVkIHRoaXMuIERvIHlvdSBtZWFuIHlvdQ0KcHJlZmVyIGFtZGdwdV9hbWRr
ZmRfcG9zdF9yZXNldCB0byBiZSBvdXRzaWRlIG9mIGFtZGdwdV9kZXZpY2VfdW5sb2NrX2FkZXYg
Pw0KPC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQo8cHJlIGNsYXNzPSJtb3otcXVvdGUtcHJlIiB3cmFw
PSIiPlllcywgZXhhY3RseS4gSXQgZG9lc24ndCBzZWVtcyB0byBiZSByZWxhdGVkIHRvIHRoZSB1
bmxvY2sgb3BlcmF0aW9uIGluIA0KdGhlIGZpcnN0IHBsYWNlLCBidXQgcmF0aGVyIG9ubHkgc2ln
bmFscyB0aGUgS0ZEIHRoYXQgdGhlIHJlc2V0IGlzIA0KY29tcGxldGVkLg0KDQpDaHJpc3RpYW4u
DQoNCjwvcHJlPg0KPC9ibG9ja3F1b3RlPg0KPC9ib2R5Pg0KPC9odG1sPg0K

--_000_1444ae5f0997d1ce3e1e23fea8822c88amdcom_--

--===============1743228239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1743228239==--
