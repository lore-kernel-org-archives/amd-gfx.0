From: Leo Li <sunpeng.li-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH xf86-video-amdgpu 03/13] List disabled color properties on
 RandR outputs without a CRTC
Date: Thu, 17 May 2018 17:43:29 -0400
Message-ID: <6d07addd-32df-c8a1-d762-186f20cfc88f@amd.com>
References: <1525372315-28462-1-git-send-email-sunpeng.li@amd.com>
 <1525372315-28462-4-git-send-email-sunpeng.li@amd.com>
 <62d1f2e3-d271-658a-7bf4-88b41b080266@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <62d1f2e3-d271-658a-7bf4-88b41b080266-otUistvHUpPR7s880joybQ@public.gmane.org>
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
Cc: harry.wentland-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

CgpPbiAyMDE4LTA1LTE2IDAxOjA5IFBNLCBNaWNoZWwgRMOkbnplciB3cm90ZToKPiBPbiAyMDE4
LTA1LTAzIDA4OjMxIFBNLCBzdW5wZW5nLmxpQGFtZC5jb20gd3JvdGU6Cj4+IEZyb206ICJMZW8g
KFN1bnBlbmcpIExpIiA8c3VucGVuZy5saUBhbWQuY29tPgo+Pgo+PiBUaGUgcHJvcGVydGllcyBv
biBhbiBSYW5kUiBvdXRwdXQgbmVlZHMgdG8gc3RheSBjb25zaXN0ZW50IHRocm91Z2hvdXQKPj4g
aXQncyBsaWZlY3ljbGUuIEhvd2V2ZXIsIHdlIGNhbm5vdCBsaXN0IGNvbG9yIHByb3BlcnRpZXMg
b24gYW4gb3V0cHV0IGlmCj4+IHRoZXJlIGlzIG5vIENSVEMgYXR0YWNoZWQuCj4+Cj4+IFRoZXJl
Zm9yZSwgY3JlYXRlIGEgZmFrZSBDUlRDLCBhbmQgaW5pdGlhbGl6ZSAiZGlzYWJsZWQiIGNvbG9y
Cj4+IHByb3Blcml0ZXMgb24gb3V0cHV0cyB3aXRob3V0IGEgQ1JUQy4KPj4KPj4gU2lnbmVkLW9m
Zi1ieTogTGVvIChTdW5wZW5nKSBMaSA8c3VucGVuZy5saUBhbWQuY29tPgo+IAo+IElmIHRoaXMg
cGF0Y2ggcmVtYWluczogSSBkb24ndCBnZXQgdGhlIHBvaW50IG9mIHRoZSBmYWtlIENSVEMuIEFG
QUlDVAo+IHJyX2NvbmZpZ3VyZV9hbmRfY2hhbmdlX2NtX3Byb3BlcnR5IGNvdWxkIHNpbXBseSBo
YW5kbGUgYSBOVUxMIGNydGMgbW9yZQo+IG9yIGxlc3MgdGhlIHNhbWUgd2F5IGl0IGRvZXMgdGhl
IGZha2Ugb25lPwo+IAo+IAoKSXQgZG9lcyBsb29rIGxpa2UgaXQgY2FuLiBNb2RpZnlpbmcgdGhl
IGNvbmRpdGlvbmFscyBmcm9tCmBpZiAoY3J0Yy0+Z2FtbWFfbHV0KWAgdG8gYGlmIChjcnRjICYm
IGNydGMtPmdhbW1hX2x1dClgIHNob3VsZCBkbyB0aGUKdHJpY2suIFRoYW5rcyBmb3IgY2F0Y2hp
bmcgdGhpcy4KCkxlbwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
