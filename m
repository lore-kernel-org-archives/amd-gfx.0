From: Emil Velikov <emil.l.velikov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: libdrm amdgpu semaphores questions
Date: Thu, 1 Dec 2016 17:14:20 +0000
Message-ID: <CACvgo50AaAkYRgAviO9ugdYcb7M4feTwgtEqQUAcGjtxFTVZSw@mail.gmail.com>
References: <CAPM=9twrphvnNx99H4r3ROaNaKMKj7uwuii_1Ph57Vv7Z-aFSg@mail.gmail.com>
 <420B93AA-EBE2-4DB4-B0D0-AE574AEFA22B@amd.com> <583FB287.5050602@amd.com>
 <CAPM=9tz2Qv0DXp-Tpfb38b81G1Gbs0MyM4KvUcvj5m+sp3dhoQ@mail.gmail.com>
 <583FBF14.8000506@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <583FBF14.8000506-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <david1.zhou-5C7GfCeVMHo@public.gmane.org>
Cc: Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Mao,
 David" <David.Mao-5C7GfCeVMHo@public.gmane.org>

T24gMSBEZWNlbWJlciAyMDE2IGF0IDA2OjExLCB6aG91Y20xIDxkYXZpZDEuemhvdUBhbWQuY29t
PiB3cm90ZToKPiBIaSBEYXZlLAo+Cj4gQXMgdGhlIGF0dGFjaGVkLCBvdXIgVnVsa2FuIHRlYW0g
aXMgdmVyaWZ5aW5nIGl0Lgo+CkRhdmlkLCBwbGVhc2UgcmVhZCB0aHJvdWdoIHRoZSBmb2xsb3dp
bmcgZG9jdW1lbnRzIHdoZW4gZGVzaWduaW5nCmlvY3RscyBbMV0gYW5kIFtpbV1wb3J0aW5nIHRo
ZSBVQUJJIHRvIGxpYmRybSBbMl0uCgpUaGFua3MKRW1pbAoKWzFdIGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvY2dpdC9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3Vt
ZW50YXRpb24vaW9jdGwvYm90Y2hpbmctdXAtaW9jdGxzLnR4dAoiUHJlcmVxdWlzaXRlcyMxIgoK
WzJdIGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvbWVzYS9kcm0vdHJlZS9pbmNsdWRlL2Ry
bS9SRUFETUUKIldoZW4gYW5kIGhvdyB0byB1cGRhdGUgdGhlc2UgZmlsZXMiIGFuZCAiYW1kZ3B1
X2RybS5oIgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwph
bWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczov
L2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
