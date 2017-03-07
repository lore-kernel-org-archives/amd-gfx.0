From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] Add support for high priority scheduling in amdgpu v5
Date: Tue, 7 Mar 2017 11:43:06 +0100
Message-ID: <304a2406-ba6e-c30a-e547-3d324a8ee20a@vodafone.de>
References: <20170307011048.3619-1-andresx7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20170307011048.3619-1-andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: Andres Rodriguez <andresx7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

UGF0Y2hlcyAjMTAgYW5kICMxNiBhcmUgUmV2aWV3ZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgCjxj
aHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKUGF0Y2hlcyAjMjAgYW5kICMyMSBhcmUgQWNrZWQt
Ynk6IENocmlzdGlhbiBLw7ZuaWcgCjxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+LgoKR2l2ZSBt
ZSBhIHNlY29uZCB0byBnbyB0aHJvdWdoIHBhdGNoICMxOCBvbmNlIG1vcmUsIGJ1dCBhcGFydCBm
cm9tIHRoYXQgCnRoZSBzZXJpZXMgaXMgcmVhZHkgdG8gbGFuZCBpZiBGZWxpeCBhbmQgQWxleCBk
b24ndCBoYXZlIG1vcmUgY29tbWVudHMuCgpSZWdhcmRzLApDaHJpc3RpYW4uCgpBbSAwNy4wMy4y
MDE3IHVtIDAyOjEwIHNjaHJpZWIgQW5kcmVzIFJvZHJpZ3VlejoKPiBVcGRhdGVkIHdpdGggZmVl
ZGJhY2sgZnJvbSBwcmV2aW91cyByZXZpZXcuCj4KPiBrZnRlc3QgcmVzdWx0cyBhcmUgYXZhaWxh
YmxlIGhlcmU6Cj4gaHR0cHM6Ly9oYXN0ZWJpbi5jb20vbGV2YWhpbGljZS5jcwo+Cj4gU2VyaWVz
IGlzIGFsc28gYXZhaWxhYmxlIGF0Ogo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sb3N0Z29hdC9saW51
eC9jb21taXRzL3dpcC1oaWdoLXByaW9yaXR5LXY1Cj4KPiBfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwo+IGFtZC1nZnggbWFpbGluZyBsaXN0Cj4gYW1kLWdm
eEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPiBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2FtZC1nZngKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2FtZC1nZngK
