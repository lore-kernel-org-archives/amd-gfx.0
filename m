From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/6] Use new DRM API where possible, and cleanups.
Date: Fri, 13 Oct 2017 12:35:08 -0400
Message-ID: <cdeccfe9-3ccd-fa7d-15cc-8f9ef5b29ca5@amd.com>
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
Cc: maarten.lankhorst-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGF0Y2hlcyAzLTYgYXJlClJldmlld2VkLWJ5OiBIYXJyeSBXZW50bGFuZCA8aGFycnkud2VudGxh
bmRAYW1kLmNvbT4KCkhhcnJ5CgpPbiAyMDE3LTEwLTEyIDA1OjE1IFBNLCBzdW5wZW5nLmxpQGFt
ZC5jb20gd3JvdGU6Cj4gRnJvbTogIkxlbyAoU3VucGVuZykgTGkiIDxzdW5wZW5nLmxpQGFtZC5j
b20+Cj4gCj4gSGkgRGF2ZSwKPiAKPiBUaGlzIHNlcmllcyByZXdvcmtzIHRoZSBwcmV2aW91cyBw
YXRjaC4gUGF0Y2ggMSBpcyBhIHYyIG9mIHRoZSBwcmV2aW91cywKPiBhbmQgYWRkaXRpb25hbCBw
YXRjaGVzIGFyZSBmcm9tIHRoZSBmZWVkYmFjayByZWNlaXZlZC4gVGhleSBhcHBseSBvbiB0b3AK
PiBvZiB5b3VyIGRybS1uZXh0LWFtZC1kYy1zdGFnaW5nIGJyYW5jaC4KPiAKPiBUaGFua3MsCj4g
TGVvCj4gCj4gTGVvIChTdW5wZW5nKSBMaSAoNik6Cj4gICBkcm0vYW1kL2Rpc3BsYXk6IFVzZSBE
Uk0gbmV3LXN0eWxlIG9iamVjdCBpdGVyYXRvcnMuCj4gICBkcm0vYW1kL2Rpc3BsYXk6IFVzZSBu
ZXcgRFJNIEFQSSB3aGVyZSBwb3NzaWJsZQo+ICAgZHJtL2FtZC9kaXNwbGF5OiBVbmlmeSBEUk0g
c3RhdGUgdmFyaWFibGUgbmFtaW5ncy4KPiAgIGRybS9hbWQvZGlzcGxheTogVW5pZnkgYW1kZ3B1
X2RtIHN0YXRlIHZhcmlhYmxlIG5hbWluZ3MuCj4gICBkcm0vYW1kL2Rpc3BsYXk6IEZpeCB0eXBv
Cj4gICBkcm0vYW1kL2Rpc3BsYXk6IFJlbW92ZSB1c2VsZXNzIHBjcnRjIHBvaW50ZXIKPiAKPiAg
ZHJpdmVycy9ncHUvZHJtL2FtZC9kaXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYyB8IDMyMCAr
KysrKysrKysrKy0tLS0tLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRn
cHVfZG0vYW1kZ3B1X2RtLmggfCAgIDMgKy0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNTYgaW5zZXJ0
aW9ucygrKSwgMTY3IGRlbGV0aW9ucygtKQo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZy
ZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2FtZC1nZngK
