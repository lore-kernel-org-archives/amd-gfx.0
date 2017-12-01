From: Slava Abramov <sabramov-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH libdrm 0/3] amdgpu: amdgpu_get_marketing_name cleanups
Date: Fri, 1 Dec 2017 12:27:19 -0500
Message-ID: <82b510fe-2c2a-0dec-6385-4745fc980913@amd.com>
References: <20171201165618.19629-1-michel@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171201165618.19629-1-michel-otUistvHUpPR7s880joybQ@public.gmane.org>
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
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T24gMjAxNy0xMi0wMSAxMTo1NiBBTSwgTWljaGVsIETDpG56ZXIgd3JvdGU6Cj4gRnJvbTogTWlj
aGVsIETDpG56ZXIgPG1pY2hlbC5kYWVuemVyQGFtZC5jb20+Cj4KPiBUaGUgZmlyc3QgdHdvIHBh
dGNoZXMgYXJlIHByZXBhcmF0b3J5IGZvciBwYXRjaCAzLCB3aGljaCBpcyB0aGUgbWVhdCBvZgo+
IHRoZSBzZXJpZXMuCj4KPiBNaWNoZWwgRMOkbnplciAoMyk6Cj4gICAgYW1kZ3B1OiBDbGVhbiB1
cCBhbWRncHVfcGFyc2VfYXNpY19pZHMgZXJyb3IgaGFuZGxpbmcKPiAgICBhbWRncHU6IFNpbXBs
aWZ5IGVycm9yIGhhbmRsaW5nIGluIHBhcnNlX29uZV9saW5lCj4gICAgYW1kZ3B1OiBPbmx5IHJl
bWVtYmVyIHRoZSBkZXZpY2UncyBtYXJrZXRpbmcgbmFtZQo+Cj4gICBhbWRncHUvQW5kcm9pZC5t
ayAgICAgICAgfCAgIDMgKy0KPiAgIGFtZGdwdS9NYWtlZmlsZS5hbSAgICAgICB8ICAgNSArLQo+
ICAgYW1kZ3B1L2FtZGdwdV9hc2ljX2lkLmMgIHwgMTM5ICsrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICBhbWRncHUvYW1kZ3B1X2RldmljZS5jICAgfCAg
MjcgKy0tLS0tLS0tCj4gICBhbWRncHUvYW1kZ3B1X2ludGVybmFsLmggfCAgMTEgKy0tLQo+ICAg
NSBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAxMzYgZGVsZXRpb25zKC0pCj4KClNl
cmllcwpBY2tlZC1ieTogU2xhdmEgQWJyYW1vdiA8c2xhdmEuYWJyYW1vdkBhbWQuY29tPgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxp
bmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVk
ZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
