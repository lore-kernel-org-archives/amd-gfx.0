From: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xserver 3/6] modesetting: add DRI2 page flip support
Date: Fri, 19 Aug 2016 07:06:54 +0000
Message-ID: <DM5PR12MB120959145EBDFF1847B5FF1A8F160@DM5PR12MB1209.namprd12.prod.outlook.com>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
 <1471429751-17269-4-git-send-email-Qiang.Yu@amd.com>,
 <7ae3a1a6-0e00-856b-885f-a8c39e7d5842@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7ae3a1a6-0e00-856b-885f-a8c39e7d5842-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?iso-8859-1?Q?Michel_D=E4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

Cgo+ICtzdGF0aWMgQm9vbAo+ICtjYW5fZXhjaGFuZ2UoU2NybkluZm9QdHIgc2NybiwgRHJhd2Fi
bGVQdHIgZHJhdywKPiArICAgICAgICAgIERSSTJCdWZmZXJQdHIgZnJvbnQsIERSSTJCdWZmZXJQ
dHIgYmFjaykKPiArewoKWy4uLl0KCj4gKyAgICBpZiAoIXVwZGF0ZV9mcm9udChkcmF3LCBmcm9u
dCkpCj4gKyAgICAgICAgcmV0dXJuIEZBTFNFOwoKSSBrbm93IHlvdSBqdXN0IGNvcGllZCB0aGlz
IGZyb20gLWF0aS9hbWRncHUsIGJ1dDogSSBkb24ndCB0aGluawpjYW5fZXhjaGFuZ2Ugc2hvdWxk
IGNhbGwgdXBkYXRlX2Zyb250LCBvciB0aGUgZnJvbnQgYnVmZmVyIG1heSBiZQp1cGRhdGVkIGV2
ZW4gdGhvdWdoIHRoZSBmbGlwIGxhdGVyIGZhaWxzLgpbeXVxXSBzbyB5b3UgbWVhbiBJIGNhbiBq
dXN0IGRyb3AgdXBkYXRlX2Zyb250IGhlcmUgYW5kIHVzZSAiZnJvbnQiCmRpcmVjdGx5PwoKCj4g
KyAgICAvKiBQb3N0IGRhbWFnZSBvbiB0aGUgZnJvbnQgYnVmZmVyIHNvIHRoYXQgbGlzdGVuZXJz
LCBzdWNoCj4gKyAgICAgKiBhcyBEaXNwbGF5TGluayBrbm93IHRha2UgYSBjb3B5IGFuZCBzaG92
ZSBpdCBvdmVyIHRoZSBVU0IuCj4gKyAgICAgKiBhbHNvIGZvciBzdyBjdXJzb3JzLgo+ICsgICAg
ICovCgpTVyBjdXJzb3JzIGNhbm5vdCB3b3JrIGNvcnJlY3RseSB3aXRoIHBhZ2UgZmxpcHBpbmcu
IEZvciB0aGF0IHJlYXNvbiwKeGY4Ni12aWRlby1hdGkvYW1kZ3B1IGRpc2FibGUgcGFnZSBmbGlw
cGluZyB3aGlsZSB0aGVyZSdzIGFuIFNXIGN1cnNvci4KW3l1cV0gd2h5PyBJcyB0aGUgcHJvYmxl
bSBpbiBrZXJuZWwgb3IgeHNlcnZlcj8KClJlZ2FyZHMsClFpYW5nIApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
