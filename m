From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: move MMU notifier related defines to
 amdgpu_mn.h
Date: Mon, 11 Sep 2017 09:36:45 +0200
Message-ID: <c35bf484-2e4d-a848-cfc2-45f7c882a9ba@vodafone.de>
References: <1504885936-17207-1-git-send-email-deathsimple@vodafone.de>
 <1504885936-17207-2-git-send-email-deathsimple@vodafone.de>
 <a27909e8-6045-59c4-a63e-93c72182f86a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <a27909e8-6045-59c4-a63e-93c72182f86a-otUistvHUpPR7s880joybQ@public.gmane.org>
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

QW0gMTEuMDkuMjAxNyB1bSAwMjo1NSBzY2hyaWViIE1pY2hlbCBEw6RuemVyOgo+IE9uIDA5LzA5
LzE3IDEyOjUyIEFNLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBGcm9tOiBDaHJpc3RpYW4g
S8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+Cj4+IEp1c3Qgc29tZSBjbGVhbnVw
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
ICAgIHwgMjUgKy0tLS0tLS0tLS0tLS0tLQo+PiAgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1
L2FtZGdwdV9tbi5oIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAg
IDIgZmlsZXMgY2hhbmdlZCwgNTMgaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9tbi5o
Cj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHUuaCBi
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+IGluZGV4IDJiZGUzMTUuLmEz
NGM0Y2IgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5o
Cj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdS5oCj4+IEBAIC02Niw2
ICs2Niw3IEBACj4+ICAgI2luY2x1ZGUgImFtZGdwdV92Y2UuaCIKPj4gICAjaW5jbHVkZSAiYW1k
Z3B1X3Zjbi5oIgo+PiAgICNpbmNsdWRlICJhbWRncHVfZG0uaCIKPj4gKyNpbmNsdWRlICJhbWRn
cHVfbW4uaCIKPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIHRoaXMgbGluZSBpbiBvdGhlciBm
aWxlcyB3aGljaCBhY3R1YWxseQo+IHJlZmVyZW5jZSBhbWRncHVfbW4qIGluc3RlYWQgb2YgaGVy
ZS4KClllYWgsIHRoYXQgaXMgdGhlIGxvbmcgdGVybSBwbGFuLiBCdXQgZm9yIHRoZSBzaG9ydCB0
ZXJtIEkgd2FudCB0byAKZGVjb21wb3NlIGFtZGdwdS5oIGludG8gc21hbGxlciBhbmQgc21hbGxl
ciBwYXJ0cyBmaXJzdC4KCkluY2x1ZGluZyB0aGUgcGFydHMgd2hpY2ggYXJlIG9ubHkgbmVlZGVk
IGJ5IGNlcnRhaW4gY29tcG9uZW50cyBpcyB0aGUgCm5leHQgc3RlcCB0aGVuLgoKPiAgIFdpdGgg
dGhhdCwgYW5kIGZvciBwYXRjaCAxIGVpdGhlciB3YXksCj4KPiBSZXZpZXdlZC1ieTogTWljaGVs
IETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+CgpUaGFua3MsCgpDaHJpc3RpYW4uCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1h
aWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZy
ZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
