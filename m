From: Leo Liu <leo.liu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: add kernel DOC for ioctls in amdgpu_cs.c file
Date: Thu, 31 May 2018 12:49:24 -0400
Message-ID: <35e956ae-c151-b26c-fbb0-9f0fd75e353e@amd.com>
References: <20180530184251.6314-1-leo.liu@amd.com>
 <4df023fd-bac7-8369-43d7-db329ecb980a@daenzer.net>
 <a672ddb7-136b-ca31-a0cb-382b412ecac4@amd.com>
 <3290de06-a110-a80e-d423-ced432893e43@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <3290de06-a110-a80e-d423-ced432893e43-otUistvHUpPR7s880joybQ@public.gmane.org>
Content-Language: en-GB
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAwNS8zMS8yMDE4IDEyOjQ3IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTA1LTMxIDA2OjM5IFBNLCBMZW8gTGl1IHdyb3RlOgo+PiBPbiAwNS8zMS8yMDE4IDEyOjMwIFBN
LCBNaWNoZWwgRMOkbnplciB3cm90ZToKPj4+IE9uIDIwMTgtMDUtMzAgMDg6NDIgUE0sIExlbyBM
aXUgd3JvdGU6Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Ft
ZGdwdV9jcy5jCj4+Pj4gYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfY3MuYwo+
Pj4+IGluZGV4IDEyZjBkMThjNmVlOC4uMzQzZmYxMTVjZmYxIDEwMDY0NAo+Pj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCj4+Pj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMKPj4+PiBAQCAtMTIxNyw2ICsxMjE3LDQ5IEBA
IHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N1Ym1pdChzdHJ1Y3QKPj4+PiBhbWRncHVfY3NfcGFyc2Vy
ICpwLAo+Pj4+ICDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4+ICDCoCB9Cj4+Pj4gIMKgICsvKioK
Pj4+PiArICogRE9DOsKgIGFtZGdwdV9jc19pb2N0bAo+Pj4gRE9DIGNvbW1lbnRzIHNob3VsZG4n
dCBiZSB1c2VkIGZvciBmdW5jdGlvbnMsIHNlZQo+Pj4gRG9jdW1lbnRhdGlvbi9vdXRwdXQvZG9j
LWd1aWRlL2tlcm5lbC1kb2MuaHRtbCNmdW5jdGlvbi1kb2N1bWVudGF0aW9uCj4+Pgo+PiBUaGlz
IGRvYyBpcyBub3QgZm9yIHRoZSBmdW5jdGlvbnMsIGl0J3MgbGlrZSBzb21ldGhpbmcgaW4gY29t
bWl0IG1lc3NhZ2UKPj4gYWJvdXQgdGhlIGRldGFpbHMgb2YgaW4vb3V0IGRhdGEsIGFuZCB3aGF0
IGlzIHRoZSBmdW5jdGlvbmFsaXR5IGZvciB0aGlzCj4+IGlvY3RsLgo+IERhdGEgc3RydWN0dXJl
cyBzaG91bGQgYmUgZG9jdW1lbnRlZCBpbiBjb21tZW50cyBkaXJlY3RseSBhYm92ZSB0aGVpcgo+
IGRlZmluaXRpb25zLCBwZXIKPiBEb2N1bWVudGF0aW9uL291dHB1dC9kb2MtZ3VpZGUva2VybmVs
LWRvYy5odG1sI3N0cnVjdHVyZS11bmlvbi1hbmQtZW51bWVyYXRpb24tZG9jdW1lbnRhdGlvbgo+
IC4gV2hhdCBhbiBpb2N0bCBkb2VzIHNob3VsZCBiZSBkZXNjcmliZWQgaW4gdGhlIGZ1bmN0aW9u
IGRvY3VtZW50YXRpb24KPiBjb21tZW50IGFib3ZlIGl0cyBpbXBsZW1lbnRhdGlvbiwgYXMgZGVz
Y3JpYmVkIGFib3ZlLgpUaGVuIHdoYXQgZG8geW91IHRoaW5rIHRoZSBrZXJuZWwgZG9jIGZvciBp
b2N0bCBzaG91bGQgZG8/CgpMZW8KCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5m
by9hbWQtZ2Z4Cg==
