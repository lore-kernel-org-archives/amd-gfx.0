From: "Grodzovsky, Andrey" <Andrey.Grodzovsky-5C7GfCeVMHo@public.gmane.org>
Subject: Re: "ring gfx timeout" with Vega 64 on mesa 19.0.0-rc2 and kernel
 5.0.0-rc6 (GPU reset still not works)
Date: Tue, 19 Feb 2019 15:24:14 +0000
Message-ID: <9b306b4d-52de-4e47-0755-6e5ab3a7b1c8@amd.com>
References: <CABXGCsOakru4=RMrhpocLhN99LwKp4q1-UfFJrEUh7q4UeKJ_g@mail.gmail.com>
 <47477f0a-76dd-2f33-ff38-01f8216cffcc@amd.com>
 <CABXGCsMMOx+Ay7Dkjfy1bKcvnsqEE0v2XnZzLNVM3ygM4G2PWg@mail.gmail.com>
 <0349a887-b5b2-827a-830a-91c93dc9628d@amd.com>
 <CABXGCsMWKw2wkQmKeRj1CNwx2=EMMcBG=XvVqGMKshOXiQ7ZsQ@mail.gmail.com>
 <024290f1-97e2-ee24-6f54-3fe14a3855cf@amd.com>
 <CABXGCsOngQCDrG2GhuXTO0FaonXzK7qwe3wRdW_oPg_OLGryDg@mail.gmail.com>
 <12b7ac94-f093-d606-ead4-463c747a716c@amd.com>
 <CABXGCsM4a0XuFbhLobJriRxa55C_zgWtexg=t_6A9Dwn1vt9bg@mail.gmail.com>
 <b10e4e75-921d-e89f-2a32-68aa8437854b@amd.com>
 <CABXGCsO-shqmH1ZLsT0M+AfyHkOJDN986DeV0SF+8vLG63=0Zw@mail.gmail.com>
 <249fa2ee-136f-3d6a-5f81-f768fe234000@amd.com>
 <936118e1-ec6a-2af4-7cea-c26bd2d5ffc8@gmail.com>
 <6cc267ec-6899-9fdf-1adc-57b96330d2d8@amd.com>
 <CABXGCsO-mx1GbV+JmKcMzcgWwTEqGo7_-ZD7Zo9BOe55Hsd3Cg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABXGCsO-mx1GbV+JmKcMzcgWwTEqGo7_-ZD7Zo9BOe55Hsd3Cg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <A334F9159BA1C0439443C56E3BB7AE87-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
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
To: Mikhail Gavrilov <mikhail.v.gavrilov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

SnVzdCBwdWxsIGluIGxhdGVzdCBkcm0tbmV4dCBmcm9tIGhlcmUgLSANCmh0dHBzOi8vY2dpdC5m
cmVlZGVza3RvcC5vcmcvfmFnZDVmL2xpbnV4L2xvZy8/aD1hbWQtc3RhZ2luZy1kcm0tbmV4dA0K
DQpBbmRyZXkNCg0KT24gMi8xNC8xOSAxMToxOCBQTSwgTWlraGFpbCBHYXZyaWxvdiB3cm90ZToN
Cj4gT24gVGh1LCAxNCBGZWIgMjAxOSBhdCAyMDo1MSwgR3JvZHpvdnNreSwgQW5kcmV5DQo+IDxB
bmRyZXkuR3JvZHpvdnNreUBhbWQuY29tPiB3cm90ZToNCj4+IEdvdCBpdC4NCj4+DQo+PiBBbmRy
ZXkNCj4+DQo+IENvb2wsIHBsZWFzZSBkb24ndCBmb3JnZXQgZ2l2ZSBtZSBwYXRjaCBmb3IgdGVz
dGluZy4NCj4NCj4NCj4gLS0NCj4gQmVzdCBSZWdhcmRzLA0KPiBNaWtlIEdhdnJpbG92Lg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWls
aW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4
