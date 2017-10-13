From: Maarten Lankhorst <maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/6] Use new DRM API where possible, and cleanups.
Date: Fri, 13 Oct 2017 19:28:52 +0200
Message-ID: <3bbe5dac-8664-3adb-b515-7ffd6cb743be@linux.intel.com>
References: <1507842911-16975-1-git-send-email-sunpeng.li@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1507842911-16975-1-git-send-email-sunpeng.li-5C7GfCeVMHo@public.gmane.org>
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
To: sunpeng.li-5C7GfCeVMHo@public.gmane.org, airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: harry.wentland-5C7GfCeVMHo@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

T3AgMTItMTAtMTcgb20gMjM6MTUgc2NocmVlZiBzdW5wZW5nLmxpQGFtZC5jb206Cj4gRnJvbTog
IkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5jb20+Cj4KPiBIaSBEYXZlLAo+Cj4g
VGhpcyBzZXJpZXMgcmV3b3JrcyB0aGUgcHJldmlvdXMgcGF0Y2guIFBhdGNoIDEgaXMgYSB2MiBv
ZiB0aGUgcHJldmlvdXMsCj4gYW5kIGFkZGl0aW9uYWwgcGF0Y2hlcyBhcmUgZnJvbSB0aGUgZmVl
ZGJhY2sgcmVjZWl2ZWQuIFRoZXkgYXBwbHkgb24gdG9wCj4gb2YgeW91ciBkcm0tbmV4dC1hbWQt
ZGMtc3RhZ2luZyBicmFuY2guCj4KPiBUaGFua3MsCj4gTGVvCj4KPiBMZW8gKFN1bnBlbmcpIExp
ICg2KToKPiAgIGRybS9hbWQvZGlzcGxheTogVXNlIERSTSBuZXctc3R5bGUgb2JqZWN0IGl0ZXJh
dG9ycy4KPiAgIGRybS9hbWQvZGlzcGxheTogVXNlIG5ldyBEUk0gQVBJIHdoZXJlIHBvc3NpYmxl
Cj4gICBkcm0vYW1kL2Rpc3BsYXk6IFVuaWZ5IERSTSBzdGF0ZSB2YXJpYWJsZSBuYW1pbmdzLgo+
ICAgZHJtL2FtZC9kaXNwbGF5OiBVbmlmeSBhbWRncHVfZG0gc3RhdGUgdmFyaWFibGUgbmFtaW5n
cy4KPiAgIGRybS9hbWQvZGlzcGxheTogRml4IHR5cG8KPiAgIGRybS9hbWQvZGlzcGxheTogUmVt
b3ZlIHVzZWxlc3MgcGNydGMgcG9pbnRlcgo+Cj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxh
eS9hbWRncHVfZG0vYW1kZ3B1X2RtLmMgfCAzMjAgKysrKysrKysrKystLS0tLS0tLS0tLQo+ICBk
cml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5oIHwgICAzICst
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKyksIDE2NyBkZWxldGlvbnMoLSkK
PgpCZXR0ZXIsIG9ubHkgc2Nhbm5lZCB0aHJvdWdoIHRoZSBzZXJpZXMgYnV0CgpSZXZpZXdlZC1i
eTogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0QGxpbnV4LmludGVsLmNvbT4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZngg
bWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
