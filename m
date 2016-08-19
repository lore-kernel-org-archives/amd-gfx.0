From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH xserver 3/6] modesetting: add DRI2 page flip support
Date: Fri, 19 Aug 2016 18:06:54 +0900
Message-ID: <90df3f93-77e8-7c25-cbc8-ccf9b529600b@daenzer.net>
References: <1471429751-17269-1-git-send-email-Qiang.Yu@amd.com>
 <1471429751-17269-4-git-send-email-Qiang.Yu@amd.com>
 <7ae3a1a6-0e00-856b-885f-a8c39e7d5842@daenzer.net>
 <DM5PR12MB120959145EBDFF1847B5FF1A8F160@DM5PR12MB1209.namprd12.prod.outlook.com>
 <1349a122-864e-2abd-9599-c7fa41e900c2@daenzer.net>
 <MWHPR12MB12152F00C2A18FC6149473F18F160@MWHPR12MB1215.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR12MB12152F00C2A18FC6149473F18F160-Gy0DoCVfaSXDoeKT4XqzagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Yu, Qiang" <Qiang.Yu-5C7GfCeVMHo@public.gmane.org>
Cc: "xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org" <xorg-devel-go0+a7rfsptAfugRpC6u6w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

T24gMTkvMDgvMTYgMDQ6NDggUE0sIFl1LCBRaWFuZyB3cm90ZToKPiAKPj4+Pj4gKyAgICAvKiBQ
b3N0IGRhbWFnZSBvbiB0aGUgZnJvbnQgYnVmZmVyIHNvIHRoYXQgbGlzdGVuZXJzLCBzdWNoCj4+
Pj4+ICsgICAgICogYXMgRGlzcGxheUxpbmsga25vdyB0YWtlIGEgY29weSBhbmQgc2hvdmUgaXQg
b3ZlciB0aGUgVVNCLgo+Pj4+PiArICAgICAqIGFsc28gZm9yIHN3IGN1cnNvcnMuCj4+Pj4+ICsg
ICAgICovCj4+Pj4KPj4+PiBTVyBjdXJzb3JzIGNhbm5vdCB3b3JrIGNvcnJlY3RseSB3aXRoIHBh
Z2UgZmxpcHBpbmcuIEZvciB0aGF0IHJlYXNvbiwKPj4+PiB4Zjg2LXZpZGVvLWF0aS9hbWRncHUg
ZGlzYWJsZSBwYWdlIGZsaXBwaW5nIHdoaWxlIHRoZXJlJ3MgYW4gU1cgY3Vyc29yLgo+Pj4gW3l1
cV0gd2h5PyBJcyB0aGUgcHJvYmxlbSBpbiBrZXJuZWwgb3IgeHNlcnZlcj8KPj4gCj4+IFRoZSBs
YXR0ZXIsIGR1ZSB0byB0aGUgd2F5IFNXIGN1cnNvciB3b3Jrcy4gVGhlcmUncyBhIGZ1bmRhbWVu
dGFsIChhbmQKPj4gbGlrZWx5IHVuZml4YWJsZSkgY29uZmxpY3QgYmV0d2VlbiB0aGUgU1cgY3Vy
c29yIGFuZCBwYWdlIGZsaXBwaW5nIGNvbmNlcHRzLgo+IAo+IFt5dXFdIFNvIHRoZSBzYW1lIHBy
b2JsZW0gZm9yIG1vZGVzZXR0aW5nPyBJIHNlZSBubyBjaGVja2luZyBTVyBjdXJzb3IKPiBpbiBv
cmlnaW5hbCBwcmVzZW50IHBhZ2UgZmxpcC4KClJpZ2h0LCBpdCdzIGN1cnJlbnRseSBicm9rZW4g
d2l0aCB0aGUgbW9kZXNldHRpbmcgZHJpdmVyLgoKTm90ZSB0aGF0IEknbSBub3Qgc2F5aW5nIHlv
dSBuZWVkIHRvIGFkZHJlc3MgdGhhdCBhcyBwYXJ0IG9mIHRoaXMKc2VyaWVzLCBqdXN0IHRoYXQg
dGhlIGNvbW1lbnQgYWJvdmUgc2hvdWxkbid0IG1lbnRpb24gU1cgY3Vyc29ycy4KCgotLSAKRWFy
dGhsaW5nIE1pY2hlbCBEw6RuemVyICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIGh0dHA6
Ly93d3cuYW1kLmNvbQpMaWJyZSBzb2Z0d2FyZSBlbnRodXNpYXN0ICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgTWVzYSBhbmQgWCBkZXZlbG9wZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9hbWQtZ2Z4Cg==
