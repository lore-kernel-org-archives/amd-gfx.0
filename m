From: Harry Wentland <harry.wentland-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: add mod_freesync_user_enable to
 dm_connector_state
Date: Mon, 11 Dec 2017 11:21:28 -0500
Message-ID: <b5d7d671-0f91-2036-15a9-ce843cdac41a@amd.com>
References: <20171204205500.22759-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20171204205500.22759-1-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

T24gMjAxNy0xMi0wNCAwMzo1NSBQTSwgQWxleCBEZXVjaGVyIHdyb3RlOgo+IFdlIGRvbid0IGN1
cnJlbnRseSBleHBvc2UgdmFyaWFibGUgcmVmcmVzaCByYXRlLCBidXQgYWRkIHRoZSBzdGF0ZSB0
byB0aGUKPiBjb25uZWN0b3Igc3RhdGUgdG8gbWFrZSBpdCBlYXNpZXIgdG8gbWFpbnRhaW4gdGhl
IHN1cHBvcnQgZm9yIGl0IGZyb20gYQo+IGh3IHN1cHBvcnQgcGVyc3BlY3RpdmUgd2hpbGUgd2Ug
ZmlndXJlIG91dCB0aGUgdWFwaSBmb3IgZHJtLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1
Y2hlciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KClJldmlld2VkLWJ5OiBIYXJyeSBXZW50
bGFuZCA8aGFycnkud2VudGxhbmRAYW1kLmNvbT4KCkhhcnJ5Cgo+IC0tLQo+ICBkcml2ZXJzL2dw
dS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIHwgMSArCj4gIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2Rpc3BsYXkvYW1kZ3B1X2RtL2FtZGdwdV9kbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9k
aXNwbGF5L2FtZGdwdV9kbS9hbWRncHVfZG0uYwo+IGluZGV4IGMzMjRjM2I3NmZhYy4uYjIzNTli
YzQ5MDBkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvZGlzcGxheS9hbWRncHVf
ZG0vYW1kZ3B1X2RtLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2Rpc3BsYXkvYW1kZ3B1
X2RtL2FtZGdwdV9kbS5jCj4gQEAgLTE2ODYsNiArMTY4Niw3IEBAIHN0cnVjdCBkbV9jb25uZWN0
b3Jfc3RhdGUgewo+ICAJdWludDhfdCB1bmRlcnNjYW5fdmJvcmRlcjsKPiAgCXVpbnQ4X3QgdW5k
ZXJzY2FuX2hib3JkZXI7Cj4gIAlib29sIHVuZGVyc2Nhbl9lbmFibGU7Cj4gKwlzdHJ1Y3QgbW9k
X2ZyZWVzeW5jX3VzZXJfZW5hYmxlIHVzZXJfZW5hYmxlOwo+ICB9Owo+ICAKPiAgI2RlZmluZSB0
b19kbV9jb25uZWN0b3Jfc3RhdGUoeClcCj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJl
ZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGlu
Zm8vYW1kLWdmeAo=
