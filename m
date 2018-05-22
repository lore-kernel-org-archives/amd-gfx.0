From: Deepak Sharma <deepak.sharma-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Use GTT for dumb buffer if sg display
 enabled
Date: Tue, 22 May 2018 13:34:26 -0700
Message-ID: <1b2ccb3c-54fd-ab37-5179-7f1a49bfa328@amd.com>
References: <20180521232203.12086-1-Deepak.Sharma@amd.com>
 <f0e83630-9736-76b1-6489-265882b664d6@daenzer.net>
 <965c9ef7-44c7-86c7-d797-3bf0b767519f@gmail.com>
 <000f9d6a-af14-34d0-abfb-51fabad0c29d@daenzer.net>
 <0d1e4e69-a41f-5432-1d95-2c964051bd41@gmail.com>
 <cbceb91e-45b3-f998-8b16-c199e1906aab@daenzer.net>
 <bbf167e1-9053-3800-981f-b8cc9cc4bd22@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <bbf167e1-9053-3800-981f-b8cc9cc4bd22-5C7GfCeVMHo@public.gmane.org>
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
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: alexander.deucher-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwNS8yMi8yMDE4IDA1OjEyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IFtTTklQ
XQo+Pj4gSWYgdGhlIEJPIGlzIG1vdmVkIGZyb20gVlJBTSB0byBWUkFNICh0byBtYWtlIGl0IGxp
bmVhcikgb3IgZnJvbSBWUkFNIHRvCj4+PiBHVFQgZm9yIHNjYW5vdXQgZG9lc24ndCByZWFsbHkg
bWF0dGVyLgo+PiBOb3Qgc3VyZSB3aGF0IHlvdSBtZWFuLiBEdW1iIEJPcyBhcmUgb25seSB1c2Vk
IGZvciBDUFUgYWNjZXNzIGFuZAo+PiBzY2Fub3V0LCBhbmQgc2hvdWxkIGJlIGNyZWF0ZWQgYWNj
b3JkaW5nbHkuCj4gCj4gV2VsbCB3aGF0IEkgd2FudGVkIHRvIHNheSBpcyB0aGF0IGl0IGlzbid0
IHdvcnNlIHRoYW4gYmVmb3JlLgo+IAo+IE9uIHRoZSBvdGhlciBoYW5kIHRoaW5raW5nIGFib3V0
IGl0IHNvbWV0aGluZyBsaWtlIDUgbGluZXMgb2YgY29kZSAKPiBzb3VuZHMgdG8gYXZvaWQgdGhl
IGV4dHJhIGNvcHkgc291bmRzIHJlYXNvbmFibGUgdG8gbWUuCj4gClRoYW5rcywgSSBtaXNzZWQg
dGhhdCBwb2ludCAsIFdpbGwgdXNlIGFtZGdwdV9kaXNwbGF5X3N1cHBvcnRlZF9kb21haW5zIAph
cyBzdWdnZXN0ZWQgYW5kIHB1c2ggdjIuCgo+Pj4gQW5kIEJUVyBHVFQgQk9zIHVzZWQgZm9yIHNj
YW5vdXQgc2hvdWxkIGJlIGNyZWF0ZWQgVVNXQywgc28gdGhlIGFyZ3VtZW50Cj4+PiB0aGF0IGl0
IGlzIGZhc3RlciBmb3IgQ1BVIGFjY2VzcyBpc24ndCByZWFsbHkgdHJ1ZSBlaXRoZXIuCj4+IFlv
dSdyZSBzYXlpbmcgc2Nhbm91dCBkb2Vzbid0IHdvcmsgZnJvbSBjYWNoZWFibGUgR1RUIEJPcz8g
SWYgaXQgZG9lcwo+PiB3b3JrLCBpdCB3b3VsZCBiZSBwcmVmZXJhYmxlIGZvciBkdW1iIEJPcy4K
PiAKPiBXZWxsLCBzY2Fub3V0IGRvZXMgc2VlbSB0byB3b3JrIGZyb20gY2FjaGFibGUgR1RUIEJP
cy4gQnV0IGZyb20gdGhlIAo+IGRvY3VtZW50YXRpb24gZnJvbSB0aGUgaGFyZHdhcmUgdGVhbSBJ
J20gcHJldHR5IHN1cmUgdGhleSBuZXZlciAKPiB2YWxpZGF0ZWQgdGhpcy4KPiAKPiBBbmQgYXMg
dXN1YWxseSBub2JvZHkgZnJvbSB0aGUgaGFyZHdhcmUgZ3V5cyBJIGFza2VkIHNvIGZhciBjb3Vs
ZCBnaXZlIAo+IG1lIGEgY2xlYXIgYW5zd2VyIGlmIGl0IHdvcmtzIG9yIG5vdC4KPiAKRldJVywg
SSB0ZXN0ZWQgdGhpcyBvbiBTdG9uZXkgd2l0aCBDcm9zIHdoZXJlIGR1bWIgYnVmZmVycyB1c2Vk
IGZvciAKc3BsYXNoIHNjcmVlbiwgSXRzIHdvcmtpbmcgZmluZS4KCgo+IFJlZ2FyZHMsCj4gQ2hy
aXN0aWFuLgoKVGhhbmtzLApEZWVwYWsKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9h
bWQtZ2Z4Cg==
