From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 2/5] Hook up CRTC color management
 functions
Date: Tue, 10 Apr 2018 14:02:28 -0400
Message-ID: <8994afe3-812f-432f-27ef-ab5db3513d15@amd.com>
References: <1522094418-9102-1-git-send-email-sunpeng.li@amd.com>
 <1522094418-9102-3-git-send-email-sunpeng.li@amd.com>
 <01457540-fbc7-b608-4aee-5df18f7a7dde@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <01457540-fbc7-b608-4aee-5df18f7a7dde-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE4LTA0LTA5IDExOjAzIEFNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTAzLTI2IDEwOjAwIFBNLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6Cj4+IEZyb206ICJMZW8g
KFN1bnBlbmcpIExpIiA8c3VucGVuZy5saUBhbWQuY29tPgo+Pgo+PiBUaGUgZnVuY3Rpb25zIGlu
c2VydCBpbnRvIHRoZSBvdXRwdXQgcmVzb3VyY2UgY3JlYXRpb24sIGFuZCBwcm9wZXJ0eQo+PiBj
aGFuZ2UgZnVuY3Rpb25zLiBDUlRDIGRlc3Ryb3kgaXMgYWxzbyBob29rZWQtdXAgZm9yIHByb3Bl
ciBjbGVhbnVwIG9mCj4+IHRoZSBDUlRDIHByb3BlcnR5IGxpc3QuCj4+Cj4+IFNpZ25lZC1vZmYt
Ynk6IExlbyAoU3VucGVuZykgTGkgPHN1bnBlbmcubGlAYW1kLmNvbT4KPiAKPiBbLi4uXQo+IAo+
PiBAQCAtMTkzMyw2ICsxOTMzLDkgQEAgc3RhdGljIHZvaWQgZHJtbW9kZV9vdXRwdXRfY3JlYXRl
X3Jlc291cmNlcyh4Zjg2T3V0cHV0UHRyIG91dHB1dCkKPj4gICAJCQl9Cj4+ICAgCQl9Cj4+ICAg
CX0KPj4gKwo+PiArCWlmIChvdXRwdXQtPmNydGMpCj4+ICsJCWRybW1vZGVfY3J0Y19jcmVhdGVf
cmVzb3VyY2VzKG91dHB1dC0+Y3J0Yywgb3V0cHV0KTsKPiAKPiBvdXRwdXQtPmNydGMgaXMgb25s
eSBub24tTlVMTCBoZXJlIGZvciBvdXRwdXRzIHdoaWNoIGFyZSBlbmFibGVkIGF0IFhvcmcKPiBz
dGFydHVwOyBvdGhlciBvdXRwdXRzIHdvbid0IGhhdmUgdGhlIG5ldyBwcm9wZXJ0aWVzLgoKSXMg
aXQgbmVjZXNzYXJ5IHRvIGhhdmUgdGhlIENSVEMgcHJvcGVydGllcyBvbiBhIG91dHB1dCBpZiB0
aGUgQ1JUQyBpcwpkaXNhYmxlZCBmb3IgdGhhdCBvdXRwdXQ/CgpJJ3ZlIHRlc3RlZCBob3QtcGx1
Z2dpbmcgd2l0aCB0aGlzLCBhbmQgdGhlIHByb3BlcnRpZXMgZG8gaW5pdGlhbGl6ZSBvbgpob3Qt
cGx1Zy4gVGhvdWdoIHRoZXkgc3RheSBvbiB0aGUgb3V0cHV0IG9uIGhvdC11bnBsdWcuLi4gSGF2
ZW4ndCBkdWcKaW50byB0aGlzIGp1c3QgeWV0LgoKTGVvCgo+IAo+IApfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQt
Z2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
