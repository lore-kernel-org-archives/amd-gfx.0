From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/5] amd/scheduler:remove error message if no hw fence
Date: Tue, 24 Oct 2017 11:26:57 +0200
Message-ID: <7b06f852-d224-4fc5-34ca-34ed35f82468@gmail.com>
References: <1508834534-16471-1-git-send-email-Monk.Liu@amd.com>
 <1508834534-16471-2-git-send-email-Monk.Liu@amd.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1508834534-16471-2-git-send-email-Monk.Liu-5C7GfCeVMHo@public.gmane.org>
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
To: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

QW0gMjQuMTAuMjAxNyB1bSAxMDo0MiBzY2hyaWViIE1vbmsgTGl1Ogo+IGJlY2F1c2Ugbm8gaHcg
ZmVuY2UgbWF5IGFsc28gY29tZXMgZnJvbSBhIGdwdSByZWNvdmVyCj4gYW5kIGpvYiBza2lwIGV2
ZW50LCBkb2Vzbid0IG1lYW4gcmVhbGx5IGJhZCB0aGluZwo+Cj4gQ2hhbmdlLUlkOiBJNGQ2ZTU4
MjRkZmUwNTBiYjNjYTZlYTBhZDc0ODI4NzIwYmMzNzRhYwo+IFNpZ25lZC1vZmYtYnk6IE1vbmsg
TGl1IDxNb25rLkxpdUBhbWQuY29tPgoKUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNo
cmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KCj4gLS0tCj4gICBkcml2ZXJzL2dwdS9kcm0vYW1kL3Nj
aGVkdWxlci9ncHVfc2NoZWR1bGVyLmMgfCAyIC0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9n
cHVfc2NoZWR1bGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL3NjaGVkdWxlci9ncHVfc2NoZWR1
bGVyLmMKPiBpbmRleCA5Y2JlYWRlLi4xMGQ0OWIxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+ICsrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvc2NoZWR1bGVyL2dwdV9zY2hlZHVsZXIuYwo+IEBAIC01MjUsNyArNTI1LDYgQEAgdm9p
ZCBhbWRfc2NoZWRfam9iX3JlY292ZXJ5KHN0cnVjdCBhbWRfZ3B1X3NjaGVkdWxlciAqc2NoZWQp
Cj4gICAJCQkJCSAgcik7Cj4gICAJCQlkbWFfZmVuY2VfcHV0KGZlbmNlKTsKPiAgIAkJfSBlbHNl
IHsKPiAtCQkJRFJNX0VSUk9SKCJGYWlsZWQgdG8gcnVuIGpvYiFcbiIpOwo+ICAgCQkJYW1kX3Nj
aGVkX3Byb2Nlc3Nfam9iKE5VTEwsICZzX2ZlbmNlLT5jYik7Cj4gICAJCX0KPiAgIAkJc3Bpbl9s
b2NrKCZzY2hlZC0+am9iX2xpc3RfbG9jayk7Cj4gQEAgLTY2NCw3ICs2NjMsNiBAQCBzdGF0aWMg
aW50IGFtZF9zY2hlZF9tYWluKHZvaWQgKnBhcmFtKQo+ICAgCQkJCQkgIHIpOwo+ICAgCQkJZG1h
X2ZlbmNlX3B1dChmZW5jZSk7Cj4gICAJCX0gZWxzZSB7Cj4gLQkJCURSTV9FUlJPUigiRmFpbGVk
IHRvIHJ1biBqb2IhXG4iKTsKPiAgIAkJCWFtZF9zY2hlZF9wcm9jZXNzX2pvYihOVUxMLCAmc19m
ZW5jZS0+Y2IpOwo+ICAgCQl9Cj4gICAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
